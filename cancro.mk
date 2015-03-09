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

PRODUCT_DEVICE := cancro
PRODUCT_NAME := cancro
PRODUCT_MODEL := MI 3W

PRODUCT_PROPERTY_OVERRIDES += \
    audio.offload.pcm.enable=false

PRODUCT_COPY_FILES += \
    device/xiaomi/cancro/etc/bl_lut.txt:system/etc/bl_lut.txt \
    device/xiaomi/cancro/etc/calib.cfg:system/etc/calib.cfg

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
    NFCEE_ACCESS_PATH := $(LOCAL_PATH)/nfc/nfcee_access_debug.xml
endif

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    device/xiaomi/cancro/nfc/libnfc-brcm.conf:system/etc/libnfc-brcm.conf \
    device/xiaomi/cancro/nfc/libnfc-brcm-20791b05.conf:system/etc/libnfc-brcm-20791b05.conf \
    device/xiaomi/cancro/nfc/firmware/bcm2079x-b5_firmware.ncd:system/vendor/firmware/bcm2079x-b5_firmware.ncd \
    device/xiaomi/cancro/nfc/firmware/bcm2079x-b5_pre_firmware.ncd:system/vendor/firmware/bcm2079x-b5_pre_firmware.ncd \
    $(NFCEE_ACCESS_PATH):system/etc/nfcee_access.xml
