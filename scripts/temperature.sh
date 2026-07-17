#!/usr/bin/env bash

temp=""

for zone in /sys/class/thermal/thermal_zone*; do
    type=$(<"$zone/type")

    case "$type" in
        x86_pkg_temp|Tctl|Tdie|TCPU)
            temp=$(<"$zone/temp")
            temp=$((temp / 1000))
            break
            ;;
    esac
done

if [ -n "$temp" ]; then
    echo "$temp"
else
    echo "N/A"
fi
