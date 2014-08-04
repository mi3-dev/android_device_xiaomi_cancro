/*
 * Copyright (C) 2012 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "DUALBOOT_INIT"
#include <fs_mgr.h>
#include <utils/Log.h>
#include <sys/stat.h>
#include <sys/mount.h>
#include <logwrap/logwrap.h>
#include <cutils/klog.h>
#include <sys/system_properties.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>

#define WAIT_TIMEOUT 5
#define E2FSCK_BIN      "/system/bin/e2fsck"
#define ARRAY_SIZE(a) (sizeof(a) / sizeof(*(a)))
#define INFO(x...)    KLOG_INFO(LOG_TAG, x)
#define ERROR(x...)   KLOG_ERROR(LOG_TAG, x)

#define MF_WAIT         0x1
#define MF_CHECK        0x2

#define PARTITION_SYSTEM "/dev/block/platform/msm_sdcc.1/by-name/system"
#define PARTITION_SYSTEM1 "/dev/block/platform/msm_sdcc.1/by-name/system1"
#define PARTITION_BOOT "/dev/block/platform/msm_sdcc.1/by-name/boot"
#define PARTITION_BOOT1 "/dev/block/platform/msm_sdcc.1/by-name/boot1"
#define PARTITION_MODEM "/dev/block/platform/msm_sdcc.1/by-name/modem"
#define PARTITION_MODEM1 "/dev/block/platform/msm_sdcc.1/by-name/modem1"
#define PARTITION_USERDATA "/dev/block/platform/msm_sdcc.1/by-name/userdata"
#define FILE_MOUNTSCRIPT "/system/bin/mount_ext4.sh"

int mountScriptExists() {
    struct stat sb;
    return !stat(FILE_MOUNTSCRIPT, &sb);
}

int getDualbootSyspart()
{
    char *arg = 0;
    size_t size = 0;
    int read;

    FILE *cmdline = fopen("/proc/cmdline", "rb");
    if(cmdline==NULL)  {
        ERROR("Cannot open /proc/cmdline");
        return -1;
    }

    while((read=getdelim(&arg, &size, ' ', cmdline)) != -1)
    {
        arg[read-1] = 0;
        if(!strcmp(arg, "syspart=system"))
            return 0;
        else if(!strcmp(arg, "syspart=system1"))
            return 1;
    }
    free(arg);
    fclose(cmdline);
    return -1;
}

/*
 * gettime() - returns the time in seconds of the system's monotonic clock or
 * zero on error.
 * from fs_mgr.c
 */
static time_t gettime(void)
{
    struct timespec ts;
    int ret;

    ret = clock_gettime(CLOCK_MONOTONIC, &ts);
    if (ret < 0) {
        ERROR("clock_gettime(CLOCK_MONOTONIC) failed: %s\n", strerror(errno));
        return 0;
    }

    return ts.tv_sec;
}

/*
 * from fs_mgr.c
 */
int wait_for_file(const char *filename, int timeout)
{
    struct stat info;
    time_t timeout_time = gettime() + timeout;
    int ret = -1;

    while (gettime() < timeout_time && ((ret = stat(filename, &info)) < 0))
        usleep(10000);

    return ret;
}

/*
 * from fs_mgr.c
 */
void check_fs(char *blk_device, char *fs_type, char *target)
{
    int status;
    int ret;
    long tmpmnt_flags = MS_NOATIME | MS_NOEXEC | MS_NOSUID;
    char *tmpmnt_opts = "nomblk_io_submit,errors=remount-ro";
    char *e2fsck_argv[] = {
        E2FSCK_BIN,
        "-y",
        blk_device
    };

    /* Check for the types of filesystems we know how to check */
    if (!strcmp(fs_type, "ext2") || !strcmp(fs_type, "ext3") || !strcmp(fs_type, "ext4")) {
        /*
         * First try to mount and unmount the filesystem.  We do this because
         * the kernel is more efficient than e2fsck in running the journal and
         * processing orphaned inodes, and on at least one device with a
         * performance issue in the emmc firmware, it can take e2fsck 2.5 minutes
         * to do what the kernel does in about a second.
         *
         * After mounting and unmounting the filesystem, run e2fsck, and if an
         * error is recorded in the filesystem superblock, e2fsck will do a full
         * check.  Otherwise, it does nothing.  If the kernel cannot mount the
         * filesytsem due to an error, e2fsck is still run to do a full check
         * fix the filesystem.
         */
        ret = mount(blk_device, target, fs_type, tmpmnt_flags, tmpmnt_opts);
        if (!ret) {
            umount(target);
        }

        INFO("Running %s on %s\n", E2FSCK_BIN, blk_device);

        ret = android_fork_execvp_ext(ARRAY_SIZE(e2fsck_argv), e2fsck_argv,
                                      &status, true, LOG_KLOG, true, NULL);

        if (ret < 0) {
            /* No need to check for error in fork, we can't really handle it now */
            ERROR("Failed trying to run %s\n", E2FSCK_BIN);
        }
    }

    return;
}

int patch_fstab(const char *filename, const char *filenamePatched, const char *filenameSystem, int syspart) {
    FILE *fp, *fpPatched, *fpSystem;
    char *save_ptr, *p, *dev, *line=NULL;
    size_t len = 0;
    const char *delim = " \t";
    int ret=0;

    if (syspart<0 || syspart>1) {
        ERROR("invalid/unsupported syspart number");
        ret = -EINVAL;
        goto error_out;
    }

    fp = fopen(filename, "r");
    if (fp == NULL) {
        ERROR("cannot open %s\n", filename);
        ret -EIO;
        goto error_out;
    }

    fpPatched = fopen(filenamePatched, "w+");
    if (fpPatched == NULL) {
        ERROR("cannot open file %s\n", filenamePatched);
        ret = -EIO;
        goto error_close_fp;
    }

    fpSystem = fopen(filenameSystem, "w+");
    if (fpSystem == NULL) {
        ERROR("cannot open file %s\n", filenameSystem);
        ret = -EIO;
        goto error_close_fpPatched;
    }

    while (getline(&line, &len, fp) != -1) {        
        p = line;

        // Skip any leading whitespace
        while (isspace(*p)) p++;

        // ignore comments or empty lines
        if (*p == '#' || *p == '\0')
            continue;
        
        // get mountpoint
        if (!(p = strtok_r(line, delim, &save_ptr))) {
            ERROR("Error parsing mount source\n");
            continue;
        }
        dev=p;

        // replace partitions
        if(syspart==1) {
            if(!strcmp(PARTITION_SYSTEM, dev)) 
                dev=PARTITION_SYSTEM1;
            else if(!strcmp(PARTITION_BOOT, dev))
                dev=PARTITION_BOOT1;
            else if(!strcmp(PARTITION_MODEM, dev))
                dev=PARTITION_MODEM1;
        }

        // remove userdata
        if(!strcmp(PARTITION_USERDATA, dev))
            continue;

        // write to file
        if(!strcmp(PARTITION_SYSTEM, dev) || !strcmp(PARTITION_SYSTEM1, dev)) {
            fprintf(fpSystem, "%s %s", dev, save_ptr);
        }
        else fprintf(fpPatched, "%s %s", dev, save_ptr);
    }


    free(line);
error_close_fpSystem:
    fclose(fpSystem);
error_close_fpPatched:
    fclose(fpPatched);
error_close_fp:
    fclose(fp);
error_out:
    return ret;
}

int main(int argc, char **argv)
{
    struct fstab *fstab;
    int ret=0, syspart, i, status;
    char filenamePatched[PATH_MAX], filenameSystem[PATH_MAX];

    // check arguments
    if(argc!=2) {
        ERROR("Invalid Arguments");
        return -EINVAL;
    }

    // get syspart from cmdline
    syspart = getDualbootSyspart();
    if(syspart<0) {
        ERROR("Cannot read system number");
        return -EINVAL;
    }

    // patch fstab
    sprintf(filenamePatched, "%s.patched", argv[1]);
    sprintf(filenameSystem, "%s.system", argv[1]);
    patch_fstab(argv[1], filenamePatched, filenameSystem, syspart);

    // mount system
    fstab = fs_mgr_read_fstab(filenameSystem);
    ret = fs_mgr_mount_all(fstab);
    fs_mgr_free_fstab(fstab);
    if (ret == -1) {
        ERROR("fs_mgr_mount_all returned an error\n");
    }

    // mount data
    fstab = fs_mgr_read_fstab(argv[1]);
    for (i = 0; i < fstab->num_entries; ++i) {
        struct fstab_rec* v = &fstab->recs[i];
        
        if(strcmp(PARTITION_USERDATA, v->blk_device))
            continue;

        if (v->fs_mgr_flags & MF_WAIT) {
            wait_for_file(v->blk_device, WAIT_TIMEOUT);
        }

        if (v->fs_mgr_flags & MF_CHECK) {
            check_fs(v->blk_device, v->fs_type, v->mount_point);
        }

        if(mountScriptExists()) {
            char *e2fsck_argv[] = {
                "/system/bin/mount_ext4.sh",
                v->blk_device,
                v->mount_point
            };
            ret = android_fork_execvp_ext(ARRAY_SIZE(e2fsck_argv), e2fsck_argv, &status, true, LOG_KLOG, true, NULL);
        }
        else {
            ret = mount(v->blk_device, v->mount_point,  v->fs_type, v->flags, v->fs_options);
        }
    }
    fs_mgr_free_fstab(fstab);
    if (ret == -1) {
        ERROR("error mounting userdata\n");
    }
    
    return ret;
}
