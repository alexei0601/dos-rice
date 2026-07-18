#!/usr/bin/env bash

# Temporary file used to store previous network counters
STATE="${XDG_CACHE_HOME:-$HOME/.cache}/waybar_network"

mkdir -p "$(dirname "$STATE")"

# Convert KB values to a readable format
format_speed() {
    local speed=$1

    if [ "$speed" -lt 1024 ]; then
        echo "${speed}K"
    else
        awk "BEGIN {printf \"%.1fM\", $speed/1024}"
    fi
}

# Detect the default network interface
interface=$(ip route | awk '/default/ {print $5; exit}')

# No network connection
if [ -z "$interface" ]; then
    echo "NET: OFF"
    exit 0
fi

# Check if interface statistics exist
if [ ! -f "/sys/class/net/$interface/statistics/rx_bytes" ]; then
    echo "NET: OFF"
    exit 0
fi

# Read network byte counters
rx=$(<"/sys/class/net/$interface/statistics/rx_bytes")
tx=$(<"/sys/class/net/$interface/statistics/tx_bytes")

# First run: initialize state
if [ ! -f "$STATE" ]; then
    echo "$interface $rx $tx" > "$STATE"
    echo "NET: $interface"
    exit 0
fi

# Read previous values
read old_interface old_rx old_tx < "$STATE"

# Save current values
echo "$interface $rx $tx" > "$STATE"

# Reset calculation if interface changed
if [ "$interface" != "$old_interface" ]; then
    echo "NET: $interface"
    exit 0
fi

# Calculate speed in KB/s
rx_speed=$(( (rx - old_rx) / 1024 ))
tx_speed=$(( (tx - old_tx) / 1024 ))

# Format transfer speeds
rx_speed=$(format_speed "$rx_speed")
tx_speed=$(format_speed "$tx_speed")

# Detect connection type
case "$interface" in
    wl*)
        type="WIFI"
        ;;
    en*|eth*) # Some devices use en* or eth* naming schemes
        type="ETH"
        ;;
    *)
        type="NET"
        ;;
esac

echo "NET: $type TX:${tx_speed} RX:${rx_speed}"