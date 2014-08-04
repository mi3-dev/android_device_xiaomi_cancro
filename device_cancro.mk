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
    $(LOCAL_PATH)/mount_ext4.sh:system/mount_ext4.sh

PRODUCT_PACKAGES += \
    dualboot_init

PRODUCT_PACKAGES += \
    pronto_wlan.ko

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
    $(LOCAL_PATH)/rootdir/wifi/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/rootdir/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf \
    hostapd_default.conf \
    hostapd.accept \
    hostapd.deny

PRODUCT_PACKAGES += \
    wcnss_service

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

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_cancro
PRODUCT_DEVICE := cancro
