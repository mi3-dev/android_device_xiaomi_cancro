$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/xiaomi/cancro/cancro-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/xiaomi/cancro/overlay

LOCAL_PATH := device/xiaomi/cancro

# Charger
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/ramdisk/chargeonlymode:root/sbin/chargeonlymode

#Recovery
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/mount_ext4_default.sh:recovery/root/res/dualboot/mount_ext4_default.sh \
    $(LOCAL_PATH)/recovery/mount_ext4_tdb.sh:recovery/root/res/dualboot/mount_ext4_tdb.sh

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/ramdisk/fstab.qcom:root/fstab.qcom \
    $(LOCAL_PATH)/rootdir/ramdisk/init.class_main.sh:root/init.class_main.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/init.mdm.sh:root/init.mdm.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/init.qcom.class_core.sh:root/init.qcom.class_core.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/init.qcom.early_boot.sh:root/init.qcom.early_boot.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/init.qcom.factory.sh:root/init.qcom.factory.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/init.qcom.rc:root/init.qcom.rc \
    $(LOCAL_PATH)/rootdir/ramdisk/init.qcom.sh:root/init.qcom.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/init.qcom.ssr.sh:root/init.qcom.ssr.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/init.qcom.syspart_fixup.sh:root/init.qcom.syspart_fixup.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/init.qcom.usb.rc:root/init.qcom.usb.rc \
    $(LOCAL_PATH)/rootdir/ramdisk/init.qcom.usb.sh:root/init.qcom.usb.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/init.target.rc:root/init.target.rc \
    $(LOCAL_PATH)/rootdir/ramdisk/ueventd.qcom.rc:root/ueventd.qcom.rc

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/mount_ext4.sh:system/bin/mount_ext4.sh \
    $(LOCAL_PATH)/rootdir/ramdisk/e2fsck_static:root/sbin/e2fsck_static

PRODUCT_PACKAGES += \
    dualboot_init

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/kernel/user/drivers/net/wireless/pronto_wlan.ko:system/lib/modules/pronto/pronto_wlan.ko

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/audio/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/rootdir/audio/init.qcom.audio.sh:system/etc/init.qcom.audio.sh \
    $(LOCAL_PATH)/rootdir/audio/listen_platform_info.xml:system/etc/listen_platform_info.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_3_1.xml:system/etc/mixer_paths_3_1.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_3_1_forte.xml:system/etc/mixer_paths_3_1_forte.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_3_2.xml:system/etc/mixer_paths_3_2.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_3_2_forte.xml:system/etc/mixer_paths_3_2_forte.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_4_x.xml:system/etc/mixer_paths_4_x.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_4_x_forte.xml:system/etc/mixer_paths_4_x_forte.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_5_x.xml:system/etc/mixer_paths_5_x.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_5_x_forte.xml:system/etc/mixer_paths_5_x_forte.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_auxpcm_3_1.xml:system/etc/mixer_paths_auxpcm_3_1.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_auxpcm_3_2.xml:system/etc/mixer_paths_auxpcm_3_2.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_auxpcm_4_x.xml:system/etc/mixer_paths_auxpcm_4_x.xml \
    $(LOCAL_PATH)/rootdir/audio/mixer_paths_auxpcm_5_x.xml:system/etc/mixer_paths_auxpcm_5_x.xml \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X3/MTP_X3_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X3/MTP_X3_General_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_General_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X3/MTP_X3_Global_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Global_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X3/MTP_X3_Handset_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Handset_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X3/MTP_X3_Hdmi_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Hdmi_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X3/MTP_X3_Headset_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Headset_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X3/MTP_X3_Speaker_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Speaker_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X4/MTP_X4_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Bluetooth_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X4/MTP_X4_General_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_General_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X4/MTP_X4_Global_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Global_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X4/MTP_X4_Handset_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Handset_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X4/MTP_X4_Hdmi_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Hdmi_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X4/MTP_X4_Headset_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Headset_cal.acdb \
    $(LOCAL_PATH)/rootdir/audio/acdbdata/MTP/X4/MTP_X4_Speaker_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Speaker_cal.acdb

# GPS
PRODUCT_PACKAGES += \
    gps.msm8974

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/gps/gps.conf:system/etc/gps.conf \
    $(LOCAL_PATH)/gps/flp.conf:system/etc/flp.conf \
    $(LOCAL_PATH)/gps/izat.conf:system/etc/izat.conf \
    $(LOCAL_PATH)/gps/quipc.conf:system/etc/quipc.conf \
    $(LOCAL_PATH)/gps/sap.conf:system/etc/sap.conf

# WiFi
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/rootdir/wifi/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/rootdir/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf \
    hostapd_default.conf \
    hostapd.accept \
    hostapd.deny

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/keylayout/atmel-maxtouch.kl:system/usr/keylayout/atmel-maxtouch.kl \
    $(LOCAL_PATH)/rootdir/keylayout/cyttsp_button.kl:system/usr/keylayout/cyttsp_button.kl \
    $(LOCAL_PATH)/rootdir/keylayout/fts.kl:system/usr/keylayout/fts.kl \
    $(LOCAL_PATH)/rootdir/keylayout/msm8974-taiko-mtp-snd-card_Button_Jack.kl:system/usr/keylayout/msm8974-taiko-mtp-snd-card_Button_Jack.kl \
    $(LOCAL_PATH)/rootdir/keylayout/synaptics_dsx.kl:system/usr/keylayout/synaptics_dsx.kl \
    $(LOCAL_PATH)/rootdir/keylayout/synaptics_rmi4_i2c.kl:system/usr/keylayout/synaptics_rmi4_i2c.kl

# IPC router config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

# Media profile
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml

# NFC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/nfcee_access.xml:system/etc/nfcee_access.xml \
    $(LOCAL_PATH)/configs/libnfc-brcm.conf:system/etc/libnfc-brcm.conf \
    $(LOCAL_PATH)/configs/libnfc-brcm-20791b05.conf:system/etc/libnfc-brcm-20791b05.conf

# Thermal config
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermald-8974.conf:system/etc/thermald-8974.conf \
    $(LOCAL_PATH)/configs/thermal-engine-8974.conf:system/etc/thermal-engine-8974.conf \
    $(LOCAL_PATH)/configs/thermal-engine-perf.conf:system/etc/thermal-engine-perf.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/android_model_facea.dat:system/etc/android_model_facea.dat \
    $(LOCAL_PATH)/rootdir/etc/android_model_faceg.dat:system/etc/android_model_faceg.dat \
    $(LOCAL_PATH)/rootdir/etc/hcidump.sh:system/etc/hcidump.sh \
    $(LOCAL_PATH)/rootdir/etc/hsic.control.bt.sh:system/etc/hsic.control.bt.sh \
    $(LOCAL_PATH)/rootdir/etc/init.crda.sh:system/etc/init.crda.sh \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.bt.sh:system/etc/init.qcom.bt.sh \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.coex.sh:system/etc/init.qcom.coex.sh \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.efs.sync.sh:system/etc/init.qcom.efs.sync.sh \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.fm.sh:system/etc/init.qcom.fm.sh \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.modem_links.sh:system/etc/init.qcom.modem_links.sh \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.post_boot.sh:system/etc/init.qcom.post_boot.sh \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.sdio.sh:system/etc/init.qcom.sdio.sh \
    $(LOCAL_PATH)/rootdir/etc/init.qcom.wifi.sh:system/etc/init.qcom.wifi.sh \
    $(LOCAL_PATH)/rootdir/etc/qca6234-service.sh:system/etc/qca6234-service.sh \
    $(LOCAL_PATH)/rootdir/etc/sdm_200_HOG3x3_Grid3x3_bin5_noproj_zero_reduced.bin:system/etc/sdm_200_HOG3x3_Grid3x3_bin5_noproj_zero_reduced.bin \
    $(LOCAL_PATH)/rootdir/etc/sdm_200_HOG3x3_Grid3x3_bin5_noproj_zero_reduced.bin.pca:system/etc/sdm_200_HOG3x3_Grid3x3_bin5_noproj_zero_reduced.bin.pca \
    $(LOCAL_PATH)/rootdir/etc/usf_post_boot.sh:system/etc/usf_post_boot.sh \
    $(LOCAL_PATH)/rootdir/etc/xtwifi.conf:system/etc/xtwifi.conf \
    $(LOCAL_PATH)/rootdir/etc/modem/Diag.cfg:system/etc/modem/Diag.cfg

PRODUCT_PACKAGES += \
    audiod \
    audio.a2dp.default \
    audio_policy.msm8974 \
    audio.primary.msm8974 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcompostprocbundle \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    tinymix

# Filesystem management tools
PRODUCT_PACKAGES += \
    make_ext4fs \
    e2fsck \
    setup_fs \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g \
    mkntfs \
    dumpe2fs \
    resize2fs \
    e2fsck_static \
    mke2fs_static \
    resize2fs_static

PRODUCT_PACKAGES += \
    libxml2

# Graphics
PRODUCT_PACKAGES += \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974 \
    liboverlay

# Media
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libdivxdrmdecrypt \
    libdashplayer \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVdecHevc \
    libOmxVenc \
    libstagefrighthw \
    qcmediaplayer

PRODUCT_BOOT_JARS += qcmediaplayer

# Power
PRODUCT_PACKAGES += \
    power.msm8974

# QRNGD
PRODUCT_PACKAGES += \
    qrngd \
    qrngp

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8974

# Torch
PRODUCT_PACKAGES += \
    Torch

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Misc dependency packages
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes \
    curl \
    libnl_2 \
    libbson

# ANT+
PRODUCT_PACKAGES += \
    libantradio \
    AntHalService

#Bluetooth
PRODUCT_PROPERTY_OVERRIDES += \
    qcom.bt.dev_power_class=1

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml

# Device uses high-density artwork where available
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# call dalvik heap config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-dalvik-heap.mk)

# call hwui memory config
$(call inherit-product-if-exists, frameworks/native/build/phone-xxhdpi-2048-hwui-memory.mk)

# call the proprietary setup
$(call inherit-product-if-exists, vendor/xiaomi/cancro/cancro-vendor.mk)

