#!/bin/bash

export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

echo "🔑 Fixing KVM permissions..."
sudo chown $USER /dev/kvm

echo "🖥️ Starting virtual display..."
Xvfb :1 -screen 0 1280x720x24 &
export DISPLAY=:1

echo "📱 Starting emulator..."
emulator -avd cloudphone -no-audio -no-boot-anim \
  -gpu swiftshader_indirect -no-snapshot &

echo "⏳ Waiting for boot..."
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 3; done'
adb root
echo "✅ Emulator booted!"

echo "🌐 Starting ws-scrcpy..."
nvm use 18
cd ~/ws-scrcpy
node ./dist/index.js
