# Android makefile for the WLAN Module
ifneq ($(filter cancro,$(TARGET_DEVICE)),)

include $(CLEAR_VARS)
LOCAL_MODULE              := pronto_wlan.ko
LOCAL_MODULE_TAGS         := optional
LOCAL_MODULE_CLASS        := ETC
LOCAL_MODULE_PATH         := $(TARGET_OUT)/lib/modules/pronto
LOCAL_SRC_FILES           := ../../../../device/xiaomi/cancro/kernel/user/drivers/net/wireless/pronto_wlan.ko
include $(BUILD_PREBUILT)

#Create symbolic link
$(shell mkdir -p $(TARGET_OUT)/lib/modules; \
        ln -sf /system/lib/modules/$(WLAN_CHIPSET)/$(WLAN_CHIPSET)_wlan.ko \
               $(TARGET_OUT)/lib/modules/wlan.ko)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
