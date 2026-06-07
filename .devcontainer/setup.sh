#!/bin/bash
set -e

echo "📦 Installing system deps..."
sudo apt-get update && sudo apt-get install -y \
  openjdk-17-jdk wget unzip xvfb \
  libpulse0 libgl1 libnss3 libxcomposite1 \
  libxcursor1 libxi6 libxtst6

echo "🔑 Fixing KVM permissions..."
sudo chown $USER /dev/kvm

echo "📱 Setting up Android SDK..."
mkdir -p ~/android-sdk/cmdline-tools
wget -q https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip -O /tmp/cmdtools.zip
unzip -q /tmp/cmdtools.zip -d ~/android-sdk/cmdline-tools
mv ~/android-sdk/cmdline-tools/cmdline-tools ~/android-sdk/cmdline-tools/latest
rm /tmp/cmdtools.zip

echo "🌍 Setting env vars..."
cat >> ~/.bashrc << 'ENVEOF'
export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools
ENVEOF

export ANDROID_HOME=$HOME/android-sdk
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

echo "📥 Installing SDK packages..."
yes | sdkmanager --licenses
sdkmanager "emulator" "platform-tools" "system-images;android-35;google_apis;x86_64"

echo "📲 Creating AVD..."
echo "no" | avdmanager create avd -n cloudphone \
  -k "system-images;android-35;google_apis;x86_64" \
  --device "pixel_6"

echo "🌐 Setting up ws-scrcpy..."
nvm use 18
cd ~
git clone https://github.com/NetrisTV/ws-scrcpy.git
cd ws-scrcpy
npm install
npm run dist:prod

echo "✅ Setup complete! Run .devcontainer/start.sh to launch."
