#!/bin/bash

# Get the current brightness value
current_brightness=$(xrandr --verbose | grep -i brightness | cut -f2 -d ' ')

# Calculate the new brightness value
new_brightness=$(echo "$current_brightness + 0.1" | bc)

# Ensure the new brightness value does not exceed 1.0
if (( $(echo "$new_brightness > 1.0" | bc -l) )); then
    new_brightness=1.0
fi

# Set the new brightness value
xrandr --output eDP-1 --brightness $new_brightness

# Print the new brightness value
echo "The new brightness is set to $new_brightness"
