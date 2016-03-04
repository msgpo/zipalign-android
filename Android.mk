# 
# Copyright 2008 The Android Open Source Project
#
# Zip alignment tool
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := zipalign

LOCAL_SRC_FILES := \
	ZipAlign.cpp \
	ZipEntry.cpp \
	ZipFile.cpp \
	system_properties.cpp
# add system_properties from bionic to satisfy linkage to liblog

LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/include \
	$(LOCAL_PATH)/zlib \
	$(LOCAL_PATH)/zopfli/src \
	$(LOCAL_PATH)/zopfli/src/zopfli

LOCAL_LDFLAGS += \
	$(LOCAL_PATH)/obj/local/armeabi/libandroidfw.a \
	$(LOCAL_PATH)/obj/local/armeabi/libutils.a \
	$(LOCAL_PATH)/obj/local/armeabi/libcutils.a \
	$(LOCAL_PATH)/obj/local/armeabi/liblog.a  \
	$(LOCAL_PATH)/obj/local/armeabi/libz.a  \
	$(LOCAL_PATH)/obj/local/armeabi/libzopfli.a

LOCAL_CFLAGS += -std=gnu++11
LOCAL_LDFLAGS += -static
include $(BUILD_EXECUTABLE)
