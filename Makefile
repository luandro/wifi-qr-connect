PREFIX ?= /usr/local

install:
	install -Dm755 src/wifi-qr-connect $(DESTDIR)$(PREFIX)/bin/wifi-qr-connect
	install -Dm755 src/wifi-qr-gui $(DESTDIR)$(PREFIX)/bin/wifi-qr-gui
	install -Dm644 packaging/wifi-qr-connect.desktop $(DESTDIR)$(PREFIX)/share/applications/wifi-qr-connect.desktop
	install -Dm644 assets/wifi-qr-icon.svg $(DESTDIR)$(PREFIX)/share/icons/hicolor/scalable/apps/wifi-qr-connect.svg

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/wifi-qr-connect
	rm -f $(DESTDIR)$(PREFIX)/bin/wifi-qr-gui
	rm -f $(DESTDIR)$(PREFIX)/share/applications/wifi-qr-connect.desktop
	rm -f $(DESTDIR)$(PREFIX)/share/icons/hicolor/scalable/apps/wifi-qr-connect.svg

.PHONY: install uninstall
