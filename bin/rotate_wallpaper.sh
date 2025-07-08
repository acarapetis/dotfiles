#!/bin/bash
SOURCE_DIR=/home/anthony/Pictures/Wallpaper
wallpaper="$SOURCE_DIR/$(shuf  -n 1 <(ls -C1 $SOURCE_DIR | grep -v current.txt))"

GPID=$(pgrep gdm-x-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$GPID/environ|cut -d= -f2-)

gsettings set org.gnome.desktop.background picture-uri-dark "file://$wallpaper"
echo "$wallpaper" > "$SOURCE_DIR/current.txt"
