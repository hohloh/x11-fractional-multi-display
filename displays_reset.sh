#!/bin/bash

# Get all connected outputs
connected_outputs=$(xrandr | grep " connected" | awk '{ print $1 }')

# Apply default settings to each connected output
for output in $connected_outputs; do
    # Reset the output to its preferred mode
    xrandr --output $output --auto --scale 1x1 --pos 0x0
done
