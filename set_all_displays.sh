#!/bin/bash

# Get all connected outputs
connected_outputs=$(xrandr | grep " connected" | awk '{ print $1 }')

# Define your display order manually (adjust these according to your actual setup)
# For example, if you have three displays and you want to set DP-4 on the left, DP-0 in the middle and DP-2 on the right:
declare -A display_order
display_order[0]="DP-4"
display_order[1]="DP-0"
display_order[2]="DP-2"

# Set initial position
pos_x=0

# Apply scaling and positioning to each connected output in the specified order
for i in "${!display_order[@]}"; do
    output=${display_order[$i]}
    
    # Get the current resolution of the output
    resolution=$(xrandr | grep -A1 "^$output connected" | tail -1 | awk '{print $1}')
    
    # Calculate new resolution based on scaling factor
    new_resolution=$(echo $resolution | awk -Fx -v scale=1.35 '{print int($1 * scale) "x" int($2 * scale)}')
    
    # Apply scaling and position to the output
    xrandr --output $output --scale 1.35x1.35 --pos ${pos_x}x0
    
    # Update pos_x for the next monitor
    width=$(echo $new_resolution | awk -Fx '{print $1}')
    pos_x=$((pos_x + width))
done
