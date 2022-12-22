
Debian
====================
This directory contains files used to package thmd/thm-qt
for Debian-based Linux systems. If you compile thmd/thm-qt yourself, there are some useful files here.

## thm: URI support ##


thm-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install thm-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your thm-qt binary to `/usr/bin`
and the `../../share/pixmaps/thm128.png` to `/usr/share/pixmaps`

thm-qt.protocol (KDE)

