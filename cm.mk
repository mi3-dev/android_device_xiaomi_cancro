## Specify phone tech before including full_phone
$(call inherit-product, vendor/cm/config/gsm.mk)

# Release name
PRODUCT_RELEASE_NAME := cancro

# Inherit some common CM stuff.
$(call inherit-product, vendor/cm/config/common_full_phone.mk)

# Inherit device configuration
$(call inherit-product, device/xiaomi/cancro/device_cancro.mk)

## Device identifier. This must come after all inclusions
PRODUCT_DEVICE := cancro
PRODUCT_NAME := cm_cancro
PRODUCT_BRAND := xiaomi
PRODUCT_MODEL := cancro
PRODUCT_MANUFACTURER := xiaomi
