# WiFi QR Connect

Scan Android WiFi QR codes and auto-connect via NetworkManager.

## Features

- **CLI mode**: Quick terminal-based scanning with webcam or image files
- **GUI mode**: GTK4/libadwaita graphical interface with live webcam preview
- Supports WPA/WPA2/WPA3, WEP, and open networks
- Handles hidden SSIDs
- Parses escaped characters in SSID and password

## Requirements

- Linux with NetworkManager
- `zbar-tools` (for QR scanning)
- For GUI: `python3-gi`, `gir1.2-gtk-4.0`, `gir1.2-adw-1`, `python3-pyzbar`, `python3-numpy`

## Installation

### Debian/Ubuntu
```bash
sudo apt install zbar-tools
sudo apt install python3-gi gir1.2-gtk-4.0 gir1.2-adw-1 python3-pyzbar python3-numpy  # for GUI
sudo cp src/wifi-qr-connect src/wifi-qr-gui /usr/local/bin/
sudo cp packaging/wifi-qr-connect.desktop /usr/share/applications/
sudo cp assets/wifi-qr-icon.svg /usr/share/icons/hicolor/scalable/apps/wifi-qr-connect.svg
```

### Arch Linux
```bash
sudo pacman -S zbar networkmanager gst-plugin-pipewire
sudo cp src/wifi-qr-connect src/wifi-qr-gui /usr/local/bin/
# Install AUR package when available
```

### Fedora
```bash
sudo dnf install zbar-gtk python3-gobject gtk4 python3-pillow python3-numpy
sudo cp src/wifi-qr-connect src/wifi-qr-gui /usr/local/bin/
```

## Usage

### CLI
```bash
wifi-qr-connect              # scan with webcam
wifi-qr-connect photo.png    # scan from image file
wifi-qr-connect --dry-run img.jpg  # parse without connecting
wifi-qr-connect --show-password img.png  # show password in output
```

### GUI
```bash
wifi-qr-gui
```
Or launch from application menu ("WiFi QR Connect").

## Android WiFi QR Format

```
WIFI:S:<SSID>;T:<WPA|WEP|nopass>;P:<password>;H:<true|false>;;
```

- `S`: SSID (network name)
- `T`: Authentication type (WPA, WEP, or nopass)
- `P`: Password (omitted for nopass)
- `H`: Hidden network (true/false)

## License

MIT