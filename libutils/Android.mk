# Copyright (C) 2008 The Android Open Source Project
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

LOCAL_PATH:= $(call my-dir)

commonSources:= \
	CallStack.cpp \
	FileMap.cpp \
	JenkinsHash.cpp \
	LinearTransform.cpp \
	Log.cpp \
	NativeHandle.cpp \
	Printer.cpp \
	PropertyMap.cpp \
	RefBase.cpp \
	SharedBuffer.cpp \
	Static.cpp \
	StopWatch.cpp \
	String8.cpp \
	String16.cpp \
	SystemClock.cpp \
	Threads.cpp \
	Timers.cpp \
	Tokenizer.cpp \
	Unicode.cpp \
	VectorImpl.cpp \
	misc.cpp \

# For the device, static
# =====================================================
include $(CLEAR_VARS)

# we have the common sources, plus some device-specific stuff
LOCAL_SRC_FILES:= \
	$(commonSources) \
	BlobCache.cpp \
	Looper.cpp \
	ProcessCallStack.cpp \
	Trace.cpp

ifeq ($(TARGET_ARCH),mips)
LOCAL_CFLAGS += -DALIGN_DOUBLE
endif
LOCAL_CFLAGS += -std=gnu++11 -fvisibility=protected

LOCAL_STATIC_LIBRARIES := \
	libcutils \
	libc

LOCAL_SHARED_LIBRARIES := \
        libbacktrace \
        liblog \
        libdl

LOCAL_MODULE := libutils
LOCAL_CLANG := true
LOCAL_SANITIZE := integer
LOCAL_C_INCLUDES += $(LOCAL_PATH)/../include

include $(BUILD_STATIC_LIBRARY)

# Include subdirectory makefiles
# ============================================================

include $(CLEAR_VARS)
LOCAL_MODULE := SharedBufferTest
LOCAL_STATIC_LIBRARIES := libutils libcutils
LOCAL_SHARED_LIBRARIES := liblog
LOCAL_SRC_FILES := SharedBufferTest.cpp
include $(BUILD_NATIVE_TEST)

# Build the tests in the tests/ subdirectory.
include $(call first-makefiles-under,$(LOCAL_PATH))
