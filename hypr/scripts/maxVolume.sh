#!/usr/bin/env bash

# récupère le volume actuel
current_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's/Volume: //')
if (( $(echo "$current_volume < 1.0" | bc) )); then
    # augmente le volume de 2%
    eval "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 2%+ "
else
    eval "wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1.0 "
fi
