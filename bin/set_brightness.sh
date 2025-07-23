#!/bin/bash
if [ -z "$1" ]; then
    ddcutil -d 1 getvcp 10 &
    ddcutil -d 2 getvcp 10
else
    ddcutil -d 1 setvcp 10 "$1"
    ddcutil -d 2 setvcp 10 "${2-$1}"
fi
