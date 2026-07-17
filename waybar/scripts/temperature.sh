#!/usr/bin/env bash

temp=""
WARNING=80
CRITICAL=90

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
    if [ "$temp" -ge "$CRITICAL" ]; then
        echo "CRITICAL ${temp}°C"
    elif [ "$temp" -ge "$WARNING" ]; then 
        echo "WARNING ${temp}°C"
    else 
        echo "OK ${temp}°C"
    fi
else
    echo "N/A"
fi
