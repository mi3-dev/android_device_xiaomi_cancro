ifneq ($(filter cancro,$(TARGET_DEVICE)),)

LOCAL_PATH := $(call my-dir)
include device/xiaomi/cancro/kernel/AndroidKernel.mk
include $(call all-makefiles-under,$(LOCAL_PATH))

endif
