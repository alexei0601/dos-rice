#!/usr/bin/env bash

total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
available=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)

used=$((total - available))

used_gb=$(awk "BEGIN {printf \"%.1f\", $used/1024/1024}")
total_gb=$(awk "BEGIN {printf \"%.1f\", $total/1024/1024}")

percentage=$(awk "BEGIN {printf \"%.0f\", ($used/$total)*100}")

echo "${used_gb}G/${total_gb}G (${percentage}%)"