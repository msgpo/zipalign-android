#!/bin/sh

case $1 in
  clean)
    rm -rf libs obj;
    exit 0;
  ;;
esac;

if [ ! "$NDK_ROOT" ]; then
  NDK_ROOT=~/android/android-ndk-r*;
fi;


for i in libandroidfw libcutils liblog libutils zlib zopfli; do
  cd $i;
  if [ "$i" == libandroidfw ]; then
    # CursorWindow appears to require a different STL; compile it first so its object can be used later
    $NDK_ROOT/ndk-build NDK_PROJECT_PATH=. NDK_OUT=../obj NDK_LIBS_OUT=../libs APP_BUILD_SCRIPT=./CursorWindowHack.mk NDK_TOOLCHAIN=arm-linux-androideabi-4.9 APP_PLATFORM=android-21 APP_STL=c++_static;
  fi;
  $NDK_ROOT/ndk-build NDK_PROJECT_PATH=. NDK_OUT=../obj NDK_LIBS_OUT=../libs APP_BUILD_SCRIPT=./Android.mk NDK_TOOLCHAIN=arm-linux-androideabi-4.9 APP_PLATFORM=android-21 APP_STL=gnustl_static;
  cd ..;
done;

$NDK_ROOT/ndk-build NDK_PROJECT_PATH=. APP_BUILD_SCRIPT=./Android.mk NDK_TOOLCHAIN=arm-linux-androideabi-4.9 APP_PLATFORM=android-21 APP_STL=gnustl_static;
exit 0;

