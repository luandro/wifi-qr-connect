# AGENTS.md

Instructions for AI coding agents working on this repository.
Read this file before starting any task.

---

## Project overview

**WiFi QR Connect** — a Linux tool to scan Android WiFi QR codes and auto-connect via NetworkManager.

- **CLI** (`src/wifi-qr-connect`) — Bash script (194 lines). Uses `zbarcam`/`zbarimg` for scanning, `nmcli` for connecting.
- **GUI** (`src/wifi-qr-gui`) — Python GTK4/libadwaita app (563 lines). Uses GStreamer for webcam capture, `pyzbar` for QR decoding.

Both tools parse the Android `WIFI:S:<SSID>;T:<WPA|WEP|nopass>;P:<password>;H:<true|false>;;` QR format and connect via `nmcli device wifi connect`.

---

## Dev environment

- **OS:** Linux (Pop!_OS / Ubuntu 24.04+). This is a Linux-only project — never add macOS or Windows support.
- **Python:** System Python (`/usr/bin/python3`), NOT pyenv. The GUI requires system-level GI bindings (`python3-gi`).
- **Key dependencies:** `zbar-tools`, `network-manager`, `python3-gi`, `gir1.2-gtk-4.0`, `gir1.2-adw-1`, `python3-pyzbar`, `python3-numpy`, `python3-pil`.
- **No build step.** Scripts are executable files — edit and run directly.
- **No package manager.** No `package.json`, no `requirements.txt`, no `Cargo.toml`.

### Running locally

```bash
# CLI
bash src/wifi-qr-connect --dry-run --show-password <image.png>

# GUI (requires display)
/usr/bin/python3 src/wifi-qr-gui

# Syntax checks
bash -n src/wifi-qr-connect
/usr/bin/python3 -m py_compile src/wifi-qr-gui
```

---

## Architecture rules

### Camera pipeline (GUI)

The GStreamer pipeline **must** request MJPG from the webcam, not raw RGB:

```
v4l2src → image/jpeg,width=640,height=480,framerate=30/1 → jpegdec → videoconvert → video/x-raw,format=RGB → appsink
```

Most webcams (including ThinkPads) only output MJPG/YUYV natively. Requesting `video/x-raw,format=RGB` directly from `v4l2src` fails silently.

### Single-consumer appsink design

**Never** have two consumers pulling from the same GStreamer appsink. The `_on_new_sample` callback is the only code that calls `pull-sample`. It stashes the frame for both display and the background scan thread. The scan thread reads the stash, never touches appsink directly.

### nmcli commands

NetworkManager auto-detects WPA/WEP/open from the access point. **Never** pass a `security` argument to `nmcli device wifi connect` — it's invalid and will fail.

```bash
# WPA/WPA2/WPA3 — correct
nmcli device wifi connect "SSID" password "PASS"

# Open network — correct
nmcli device wifi connect "SSID"

# Hidden network — correct
nmcli device wifi connect "SSID" password "PASS" hidden yes

# WRONG — will fail
nmcli device wifi connect "SSID" password "PASS" security wpa-psk
```

### GTK4 API

Use `invalidate_contents()`, not `invalidate()`. The latter is GTK3.

### QR parsing

Both CLI and GUI must handle escaped characters in the Android WiFi QR format: `\;`, `\:`, `\\`. The parsing logic uses placeholder substitution (`__SEMI__`, `__COLON__`, `__BSLASH__`) to unescape before splitting on `;`.

---

## CI / Releases

- **Single workflow:** `.github/workflows/release.yml` — triggers on `v*` tag push.
- **5 jobs:** `build-deb`, `build-rpm`, `build-arch`, `build-appimage`, `publish-release`.
- **GitHub Actions versions:** Use `@v7` (checkout, upload-artifact), `@v8` (download-artifact), `@v3` (action-gh-release). These use Node.js 24. **Never** downgrade to `@v4`/`@v2` — they trigger Node.js 20 deprecation warnings.
- **AppImage:** The `appimagetool` AppImage must be extracted (`--appimage-extract`) in CI because GitHub runners lack FUSE. The `squashfs-root/AppRun` binary is used instead. Exclude `appimagetool-x86_64.AppImage` from release artifacts — only ship `wifi-qr-connect-*.AppImage`.
- **AppRun:** Must use `/usr/bin/python3` explicitly (not `python3`) because users may have pyenv or other shims that lack GI bindings.

### Release process

```bash
# 1. Ensure main is clean and pushed
git checkout main && git pull

# 2. Tag and push
git tag v1.x.0
git push origin v1.x.0

# 3. CI builds all packages and publishes the release automatically
# 4. Verify: gh release view v1.x.0 --repo luandro/wifi-qr-connect
```

---

## Commit conventions

```
feat: <what changed>
fix: <what was fixed>
docs: <documentation change>
chore: <maintenance>
assets: <icon/logo changes>
```

Keep the subject line under 72 characters. Reference the issue number if applicable.

---

## What NOT to do

- **Do not** add macOS or Windows support. This is Linux-only (NetworkManager + GStreamer).
- **Do not** add a `requirements.txt` or `setup.py`. Dependencies are system packages managed by distro package managers.
- **Do not** bundle Python or GTK4 inside the AppImage. Use system-installed libraries via the AppRun wrapper.
- **Do not** add `security` argument to nmcli commands.
- **Do not** use `invalidate()` — use `invalidate_contents()` for GTK4.
- **Do not** create multiple consumers on the GStreamer appsink.
- **Do not** downgrade GitHub Actions to `@v4`/`@v2` versions.
- **Do not** add tests unless explicitly asked — this is a small utility with manual testing.
