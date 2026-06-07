#!/bin/bash
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

yes | sdkmanager --licenses
sdkmanager "emulator" "platform-tools" "system-images;android-35;google_apis;x86_64"
echo "no" | avdmanager create avd -n cloudphone \
  -k "system-images;android-35;google_apis;x86_64" \
  --device "pixel_6"
adb root
echo "✅ AVD created!"
