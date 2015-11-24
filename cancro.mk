#
# Copyright 2014 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)

# Get the long list of APNs

$(call inherit-product, device/xiaomi/msm8974-common/cancro_common.mk)
$(call inherit-product, vendor/xiaomi/cancro/cancro-vendor.mk)
DEVICE_PACKAGE_OVERLAYS += device/xiaomi/cancro/overlay
PRODUCT_DEVICE := cancro
PRODUCT_NAME := cancro
PRODUCT_MODEL := MI 3W

PRODUCT_PROPERTY_OVERRIDES += \
    audio.offload.pcm.enable=true

PRODUCT_COPY_FILES += \
    device/xiaomi/cancro/etc/bl_lut.txt:system/etc/bl_lut.txt \
    device/xiaomi/cancro/etc/calib.cfg:system/etc/calib.cfg

# Wifi 
PRODUCT_COPY_FILES += \
    device/xiaomi/cancro/etc/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin \
    device/xiaomi/cancro/etc/wifi/WCNSS_qcom_wlan_nv_x4.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_x4.bin \
    device/xiaomi/cancro/etc/wifi/WCNSS_qcom_wlan_nv_x4lte.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv_x4lte.bin

# Audio
PRODUCT_COPY_FILES += \
    device/xiaomi/cancro/etc/mixer_paths_3_1.xml:system/etc/mixer_paths_3_1.xml \
    device/xiaomi/cancro/etc/mixer_paths_3_1_forte.xml:system/etc/mixer_paths_3_1_forte.xml \
    device/xiaomi/cancro/etc/mixer_paths_3_2.xml:system/etc/mixer_paths_3_2.xml \
    device/xiaomi/cancro/etc/mixer_paths_3_2_forte.xml:system/etc/mixer_paths_3_2_forte.xml \
    device/xiaomi/cancro/etc/mixer_paths_4_x.xml:system/etc/mixer_paths_4_x.xml \
    device/xiaomi/cancro/etc/mixer_paths_4_x_forte.xml:system/etc/mixer_paths_4_x_forte.xml \
    device/xiaomi/cancro/etc/mixer_paths_auxpcm_3_1.xml:system/etc/mixer_paths_auxpcm_3_1.xml \
    device/xiaomi/cancro/etc/mixer_paths_auxpcm_3_2.xml:system/etc/mixer_paths_auxpcm_3_2.xml \
    device/xiaomi/cancro/etc/mixer_paths_auxpcm_4_x.xml:system/etc/mixer_paths_auxpcm_4_x.xml \
    device/xiaomi/cancro/etc/acdbdata/MTP/X3/MTP_X3_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Bluetooth_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X3/MTP_X3_General_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_General_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X3/MTP_X3_Global_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Global_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X3/MTP_X3_Handset_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Handset_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X3/MTP_X3_Hdmi_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Hdmi_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X3/MTP_X3_Headset_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Headset_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X3/MTP_X3_Speaker_cal.acdb:system/etc/acdbdata/MTP/X3/MTP_X3_Speaker_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X4/MTP_X4_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Bluetooth_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X4/MTP_X4_General_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_General_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X4/MTP_X4_Global_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Global_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X4/MTP_X4_Handset_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Handset_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X4/MTP_X4_Hdmi_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Hdmi_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X4/MTP_X4_Headset_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Headset_cal.acdb \
    device/xiaomi/cancro/etc/acdbdata/MTP/X4/MTP_X4_Speaker_cal.acdb:system/etc/acdbdata/MTP/X4/MTP_X4_Speaker_cal.acdb

# NFC
TARGET_USES_OS_NFC := true
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nfc.port=I2C

PRODUCT_PACKAGES += \
    nfc_nci.bcm2079x.default \
    NfcNci \
    Tag

ifeq ($(TARGET_BUILD_VARIANT),user)
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/nfc/nfcee_access.xml
else
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/nfc/nfcee_access.xml
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    device/xiaomi/cancro/nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf \
    device/xiaomi/cancro/nfc/libnfc-brcm-20791b05.conf:system/etc/libnfc-brcm-20791b05.conf \
    device/xiaomi/cancro/nfc/firmware/bcm2079x-b5_firmware.ncd:system/vendor/firmware/bcm2079x-b5_firmware.ncd \
    device/xiaomi/cancro/nfc/firmware/bcm2079x-b5_pre_firmware.ncd:system/vendor/firmware/bcm2079x-b5_pre_firmware.ncd \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml

# fmradio support
PRODUCT_PACKAGES += \
    libfmjni \
    FMRadio
