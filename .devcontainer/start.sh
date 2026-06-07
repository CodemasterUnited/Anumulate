#!/bin/bash
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

# Start virtual display
Xvfb :1 -screen 0 1280x720x24 &
export DISPLAY=:1

# Start emulator
emulator -avd cloudphone -no-audio -no-boot-anim \
  -gpu swiftshader_indirect -no-snapshot &

# Wait for boot
adb wait-for-device shell 'while [[ -z $(getprop sys.boot_completed) ]]; do sleep 3; done'
echo "✅ Emulator booted!"

# Start ws-scrcpy
cd ~/ws-scrcpy
nvm use 18
npm start
