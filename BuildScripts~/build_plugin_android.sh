#!/bin/bash

export LIBWEBRTC_DOWNLOAD_URL=https://github.com/Unity-Technologies/com.unity.webrtc/releases/download/M85/webrtc-android.zip
export SOLUTION_DIR=$(pwd)/Plugin~
export ARCH_ABI=arm64-v8a

# Download LibWebRTC 
curl -L $LIBWEBRTC_DOWNLOAD_URL > webrtc.zip
unzip -d $SOLUTION_DIR/webrtc webrtc.zip 

# Install libc++, libc++abi clang glut
# TODO:: Remove this install process from here and recreate an image to build the plugin.
sudo apt update
sudo apt install -y libc++-dev libc++abi-dev clang freeglut3-dev

# Build UnityRenderStreaming Plugin 
cd "$SOLUTION_DIR"
cmake .                                   \
  -B build                                \
  -D CMAKE_SYSTEM_NAME=Android            \
  -D CMAKE_SYSTEM_VERSION=21              \
  -D CMAKE_ANDROID_ARCH_ABI=$ARCH_ABI     \
  -D CMAKE_ANDROID_NDK=$ANDROID_NDK       \
  -D CMAKE_ANDROID_STL_TYPE=c++_shared

cmake --build build     \
  --config Release      \
  --target WebRTCPlugin