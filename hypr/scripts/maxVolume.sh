#!/bin/bash
volume=$(wpctl get-volume 57 | awk '{print $2}')
if (( $(echo "$volume >= 1.0" | bc) )); then
	eval "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1.0 "
else
	eval "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+ "
fi
