# Android makefile for the WLAN Module
ifneq ($(filter cancro,$(TARGET_DEVICE)),)

#Create symbolic link
$(shell mkdir -p $(TARGET_OUT)/lib/modules; \
        ln -sf /system/lib/modules/pronto/pronto_wlan.ko \
               $(TARGET_OUT)/lib/modules/wlan.ko)

include $(call all-makefiles-under,$(LOCAL_PATH))

endif
