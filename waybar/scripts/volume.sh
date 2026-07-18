#!/usr/bin/env bash

volume=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}' | tr -d '%')
mute=$(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}')

sink=$(pactl get-default-sink)

case "$sink" in
    *bluez*)
        output="BT"
        ;;
    *analog*|*Analog*|*pci*|*PCH*)
        output="INT"
        ;;
    *)
        output="OUT"
        ;;
esac

if [ "$mute" = "yes" ]; then
    echo "MUTE ($output)"
else
    echo "${volume}% ($output)"
fi