#!/bin/bash
SOURCE_DIR=/home/anthony/Pictures/Wallpaper
rm "$(cat $SOURCE_DIR/current.txt)"
rotate_wallpaper.sh
