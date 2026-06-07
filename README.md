# Anumulate 🤖📱

Cloud Android emulator running in GitHub Codespaces, accessible from any browser.

## First time setup
```bash
bash .devcontainer/setup.sh
```

## Start the emulator
```bash
bash .devcontainer/start.sh
```

Then open the forwarded port 8000 URL in your browser.
Use Cloudflare tunnel for public access:
```bash
cloudflared tunnel --url http://localhost:8000
```

## Install an APK
```bash
adb install your-app.apk
```
EOF 
