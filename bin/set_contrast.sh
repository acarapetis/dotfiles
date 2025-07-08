#!/bin/bash
ddcutil -d 1 setvcp 12 "$1"
#echo "${2-$1}"
ddcutil -d 2 setvcp 12 "${2-$1}"
