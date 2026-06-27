# WiFi QR Connect

Scan Android WiFi QR codes and auto-connect via NetworkManager.

Available as both a CLI tool and a GTK4/libadwaita GUI with live webcam preview.

## Features

- **CLI mode** — Quick terminal-based scanning with webcam or image files
- **GUI mode** — GTK4/libadwaita interface with live webcam preview
- Supports WPA/WPA2/WPA3, WEP, and open networks
- Handles hidden SSIDs
- Parses escaped characters in SSID and password
- Debounced QR detection to prevent duplicate scans

## Installation

### Option 1: Download a pre-built installer (recommended)

Go to the [latest release](https://github.com/luandro/wifi-qr-connect/releases/latest) and download the package for your distro:

| Distro | File | Install command |
|---|---|---|
| Debian/Ubuntu | `wifi-qr-connect_*_all.deb` | `sudo dpkg -i wifi-qr-connect_*.deb` |
| Fedora/RHEL | `wifi-qr-connect-*.noarch.rpm` | `sudo dnf install wifi-qr-connect-*.rpm` |
| Arch Linux | `wifi-qr-connect-*-arch.tar.gz` | See below |

**Arch Linux** (AUR-style):
```bash
tar -xzf wifi-qr-connect-*-arch.tar.gz
cd wifi-qr-connect-*-arch
makepkg -si
```

### Option 2: Manual install

```bash
git clone https://github.com/luandro/wifi-qr-connect.git
cd wifi-qr-connect
sudo make install
```

## Usage

### CLI

```bash
wifi-qr-connect                       # scan with webcam
wifi-qr-connect screenshot.png        # scan from image file
wifi-qr-connect --dry-run photo.jpg   # parse without connecting
wifi-qr-connect --show-password img   # show password in output
```

### GUI

```bash
wifi-qr-gui
```

Or launch from your application menu — search "WiFi QR Connect".

**Workflow:**
1. On Android: **Settings > WiFi > tap network > Share** (shows QR code)
2. Open WiFi QR Connect on your laptop
3. Click **Start Camera**, point webcam at the phone screen
4. Network details appear automatically
5. Click **Connect to Network**

## Requirements

- Linux with NetworkManager (`nmcli`)
- Webcam (for live scanning) or image file
- `zbar-tools` — QR decoding
- For GUI: `python3-gi`, `gir1.2-gtk-4.0`, `gir1.2-adw-1`, `python3-pyzbar`, `python3-numpy`, `python3-pil`

## Android WiFi QR Format

```
WIFI:S:<SSID>;T:<WPA|WEP|nopass>;P:<password>;H:<true|false>;;
```

| Field | Description |
|---|---|
| `S` | SSID (network name) |
| `T` | Authentication type (`WPA`, `WEP`, or `nopass`) |
| `P` | Password (omitted for `nopass`) |
| `H` | Hidden network (`true`/`false`) |

## Building from source

```bash
# Debian
dpkg-deb --build --root-owner-group wifi-qr-connect_VERSION_all

# Fedora
rpmbuild -bb wifi-qr-connect.spec

# Arch
makepkg -f
```

## License

[MIT](LICENSE)
