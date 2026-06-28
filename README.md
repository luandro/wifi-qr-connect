<a id="readme-top"></a>

<div align="center">

<img src="assets/wifi-qr-icon.svg" alt="WiFi QR Connect" width="120" height="120">

# WiFi QR Connect

### Scan a QR code. Connect to WiFi. That's it.

A blazing-fast Linux tool to scan Android WiFi QR codes and instantly connect via NetworkManager — no typing passwords ever again.

![Release](https://img.shields.io/github/actions/workflow/status/luandro/wifi-qr-connect/release.yml?style=flat-square&logo=github&label=Release)
![Version](https://img.shields.io/github/v/release/luandro/wifi-qr-connect?style=flat-square&logo=git&label=Version)
![License](https://img.shields.io/github/license/luandro/wifi-qr-connect?style=flat-square&logo=opensourceinitiative&label=License)
![Downloads](https://img.shields.io/github/downloads/luandro/wifi-qr-connect/total?style=flat-square&logo=github&label=Downloads)
![Platform](https://img.shields.io/badge/Platform-Linux-1793D1?style=flat-square&logo=linux&logoColor=white)

[Quick Start](#-quick-start) ·
[Install](#-installation) ·
[Usage](#-usage) ·
[How It Works](#-how-it-works) ·
[FAQ](#-faq) ·
[Contributing](#-contributing)

</div>

---

> **Point your webcam at a WiFi QR code on your phone.**  
> **The network details appear. Click connect. Done.**

No more squinting at `WPA2-PSK` passwords typed on a tiny keyboard. No more asking "what's the WiFi password?" Just scan and connect.

## ✨ Features

| | Feature | Description |
|---|---|---|
| 📷 | **Live webcam scanning** | Real-time QR detection with on-screen preview — just point and shoot |
| 🖼️ | **Image file scanning** | Got a screenshot of the QR code? Drop it in directly |
| ⌨️ | **Full CLI mode** | Pipe-friendly terminal tool for scripts and headless setups |
| 🔐 | **All security types** | WPA, WPA2, WPA3/SAE, WEP, and open networks |
| 👻 | **Hidden SSID support** | Automatically handles hidden networks |
| 🛡️ | **Password masking** | Passwords hidden by default — use `--show-password` to reveal |
| 🚀 | **Zero-config connect** | NetworkManager auto-detects security type — no manual setup |
| 🎨 | **Native GTK4/libadwaita UI** | Looks at home on GNOME, COSMIC, and modern Linux desktops |
| 📦 | **Multiple formats** | `.deb`, `.rpm`, PKGBUILD, and AppImage — all auto-built by CI |

## 🚀 Quick Start

**The fastest way to get connected:**

```bash
# 1. Install (Debian/Ubuntu)
wget -qO- https://github.com/luandro/wifi-qr-connect/releases/latest/download/wifi-qr-connect_1.0.0_all.deb | sudo dpkg -i -

# 2. On your Android phone: Settings → WiFi → tap network → Share (shows QR)

# 3. Launch the GUI and point your webcam at the screen
wifi-qr-gui
```

<details>
<summary>📦 Other distros — click to expand</summary>

```bash
# Fedora / RHEL
sudo dnf install https://github.com/luandro/wifi-qr-connect/releases/latest/download/wifi-qr-connect-1.0.0-1.noarch.rpm

# Arch Linux (AUR-style)
wget https://github.com/luandro/wifi-qr-connect/releases/latest/download/wifi-qr-connect-1.0.0-arch.tar.gz
tar -xzf wifi-qr-connect-*-arch.tar.gz && cd wifi-qr-connect-*-arch && makepkg -si

# AppImage (portable — no install needed)
chmod +x wifi-qr-connect-*-x86_64.AppImage && ./wifi-qr-connect-*-x86_64.AppImage
```
</details>

## 📥 Installation

### Option 1: Pre-built Packages (Recommended)

Download from the [latest release](https://github.com/luandro/wifi-qr-connect/releases/latest):

| Distro | File | Install Command |
|---|---|---|
| **Debian / Ubuntu** | `wifi-qr-connect_1.0.0_all.deb` | `sudo dpkg -i wifi-qr-connect_*.deb` |
| **Fedora / RHEL** | `wifi-qr-connect-1.0.0-1.noarch.rpm` | `sudo dnf install wifi-qr-connect-*.rpm` |
| **Arch Linux** | `wifi-qr-connect-1.0.0-arch.tar.gz` | `tar -xzf … && cd … && makepkg -si` |
| **Any Linux** | `wifi-qr-connect-1.0.0-x86_64.AppImage` | `chmod +x *.AppImage && ./*.AppImage` |

> **Note:** The `.deb` and `.rpm` packages automatically install all dependencies.  
> The AppImage and Arch packages require manual dependency installation (see below).

<details>
<summary>🔧 Dependency install commands by distro</summary>

```bash
# Debian / Ubuntu / Pop!_OS / Mint
sudo apt install zbar-tools network-manager python3 python3-gi \
  gir1.2-gtk-4.0 gir1.2-adw-1 python3-pyzbar python3-numpy python3-pil

# Fedora / RHEL / CentOS Stream
sudo dnf install zbar NetworkManager python3-gobject gtk4 libadwaita \
  python3-pillow python3-numpy python3-zbar

# Arch Linux / Manjaro / EndeavourOS
sudo pacman -S zbar networkmanager python-gobject gtk4 libadwaita \
  python-pillow python-numpy python-zbar
```
</details>

### Option 2: Build from Source

```bash
git clone https://github.com/luandro/wifi-qr-connect.git
cd wifi-qr-connect
sudo make install
```

Uninstall with `sudo make uninstall`.

## 📖 Usage

### GUI Mode

```bash
wifi-qr-gui
```

Or launch from your application menu — search **"WiFi QR Connect"**.

**Step-by-step:**

1. On your Android phone: **Settings → WiFi → tap your network → Share**
   *(This displays the QR code on screen)*
2. Open **WiFi QR Connect** on your laptop
3. Click **Start Camera**
4. Point your laptop's webcam at the phone screen
5. Network details appear automatically (SSID, security, password)
6. Click **Connect to Network**

You can also click **Open Image File** to scan from a saved screenshot or photo.

### CLI Mode

```bash
# Scan with webcam (live)
wifi-qr-connect

# Scan from an image file or screenshot
wifi-qr-connect screenshot.png

# Preview parsed details without connecting
wifi-qr-connect --dry-run photo.jpg

# Show the password in output (hidden by default)
wifi-qr-connect --show-password qr.png

# Show all options
wifi-qr-connect --help
```

<details>
<summary>Example CLI output</summary>

```
>>> QR code detected.

  ┌──────────────────────────────────┐
  │  SSID:     HomeNetwork_5G
  │  Security: WPA
  │  Password: ******** (12 chars)
  │  Hidden:   false
  └──────────────────────────────────┘

>>> Connecting to 'HomeNetwork_5G' via NetworkManager…
✓ Successfully connected to 'HomeNetwork_5G'
```
</details>

## 🔧 How It Works

```
┌─────────────┐     ┌──────────────┐     ┌─────────────────┐     ┌──────────┐
│  Webcam /    │────▶│  GStreamer   │────▶│  pyzbar / zbar  │────▶│  nmcli   │
│  Image File  │     │  MJPG→RGB    │     │  QR Decode      │     │  Connect │
└─────────────┘     └──────────────┘     └─────────────────┘     └──────────┘
                                                │
                                    ┌───────────▼───────────┐
                                    │  WIFI:S:SSID;T:WPA;  │
                                    │  P:password;H:false;; │
                                    └───────────────────────┘
```

1. **Capture** — GStreamer grabs MJPG frames from the webcam at 30fps and decodes to RGB
2. **Detect** — `pyzbar` scans each frame for QR codes (falls back to `zbarimg` for files)
3. **Parse** — Extracts SSID, auth type, password, and hidden flag from the Android `WIFI:` URI format
4. **Connect** — `nmcli device wifi connect` joins the network (auto-detects WPA/WEP/open)

The camera pipeline uses a **single-consumer design**: one callback pulls frames from GStreamer's appsink, stashes them for both display and the background scan thread — preventing frame starvation.

## ❓ FAQ

<details>
<summary><b>The camera preview is blank / camera doesn't start</b></summary>

Make sure no other app is using the webcam:
```bash
fuser /dev/video0
# If a process is listed, kill it:
fuser -k /dev/video0
```
Then restart the app. The pipeline requests MJPG at 640×480 — if your webcam only supports YUYV, check `/dev/video*` exists and your user is in the `video` group.
</details>

<details>
<summary><b>I get "nmcli: extra argument 'security' is invalid"</b></summary>

This was a bug in early versions. NetworkManager auto-detects the security type (WPA/WEP/open) from the access point — the `security` argument is not needed and was removed. Update to v1.0.0+.
</details>

<details>
<summary><b>Does it work on macOS or Windows?</b></summary>

**No.** This tool relies on Linux's NetworkManager (`nmcli`) for WiFi connections and GStreamer for webcam capture. It's Linux-only by design.
</details>

<details>
<summary><b>What's the Android WiFi QR format?</b></summary>

```
WIFI:S:<SSID>;T:<WPA|WEP|nopass>;P:<password>;H:<true|false>;;
```
| Field | Meaning |
|---|---|
| `S` | Network name (SSID) |
| `T` | Auth type: `WPA`, `WEP`, or `nopass` |
| `P` | Password (omitted for open networks) |
| `H` | Hidden network: `true` or `false` |

Special characters in SSID/password are escaped with backslash (`\;`, `\:`, `\\`).
</details>

<details>
<summary><b>Can I generate my own WiFi QR code?</b></summary>

Yes! Use `qrencode`:
```bash
qrencode -o wifi.png "WIFI:S:MyNetwork;T:WPA;P:MyPassword123;H:false;;"
```
</details>

## 🏗️ Building Packages

All packages are auto-built by GitHub Actions CI on every tagged release. To build locally:

```bash
# Debian .deb
dpkg-deb --build --root-owner-group wifi-qr-connect_VERSION_all

# Fedora .rpm
rpmbuild -bb wifi-qr-connect.spec

# Arch PKGBUILD
makepkg -f

# AppImage
./appimagetool-x86_64.AppImage AppDir wifi-qr-connect.AppImage
```

## 🤝 Contributing

Contributions are welcome! This is a small, focused tool — here's how to help:

1. **Fork** the repository
2. Create a feature branch: `git checkout -b feature/amazing-feature`
3. Commit your changes: `git commit -m 'Add amazing feature'`
4. Push to the branch: `git push origin feature/amazing-feature`
5. Open a **Pull Request**

### Areas for improvement

- [ ] Flatpak package
- [ ] Snap package
- [ ] Multi-language support (i18n)
- [ ] QR code generation from within the GUI
- [ ] Connection history / saved networks

## 📋 Requirements

| Requirement | CLI | GUI |
|---|:---:|:---:|
| Linux + NetworkManager (`nmcli`) | ✅ | ✅ |
| `zbar-tools` (zbarcam / zbarimg) | ✅ | ✅ |
| Webcam or image file | ✅ | ✅ |
| Python 3 + GTK4 + libadwaita + GStreamer | — | ✅ |
| `python3-pyzbar`, `python3-numpy`, `python3-pil` | — | ✅ |

## 📄 License

Distributed under the **MIT License**. See [`LICENSE`](LICENSE) for details.

---

<div align="center">

Made with ⚡ by [Luandro](https://github.com/luandro)

[Report Bug](https://github.com/luandro/wifi-qr-connect/issues/new?labels=bug) ·
[Request Feature](https://github.com/luandro/wifi-qr-connect/issues/new?labels=enhancement) ·
[⭐ Star this repo](https://github.com/luandro/wifi-qr-connect)

</div>
