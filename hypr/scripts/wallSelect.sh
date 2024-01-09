#!/usr/bin/env bash
if ! command -v xdpyinfo > /dev/null 2>&1; then
    dunstify "Missing package" "Please install the xorg-xdpyinfo package to continue" -u critical
    exit 1
elif ! command -v convert > /dev/null 2>&1; then
	dunstify "Missing package" "Please install the imagemagick package to continue" -u critical
    exit 1
fi

# Set some variables
wall_dir="${HOME}/.config/hypr/wallpapers"
cacheDir="${HOME}/.cache/wallSelect"
rofi_command="rofi -dmenu -theme ${HOME}/.config/rofi/wallSelect.rasi -theme-str ${rofi_override}"

monitor_res=$(xdpyinfo | grep dimensions | awk '{print $2}' | cut -d 'x' -f1)
monitor_scale=$(xdpyinfo | grep -oP "resolution:.*" | awk '{print $2}' | cut -d 'x' -f1)
monitor_res=$(( monitor_res * 17 / monitor_scale ))
rofi_override="element-icon{size:${monitor_res}px;border-radius:0px;}"

# Create cache dir if not exists
if [ ! -d "${cacheDir}" ] ; then
        mkdir -p "${cacheDir}"
    fi

# Convert images in directory and save to cache dir
for imagen in "$wall_dir"/*.{jpg,jpeg,png,webp}; do
	if [ -f "$imagen" ]; then
		nombre_archivo=$(basename "$imagen")
			if [ ! -f "${cacheDir}/${nombre_archivo}" ] ; then
				convert -strip "$imagen" -thumbnail 500x500^ -gravity center -extent 500x500 "${cacheDir}/${nombre_archivo}"
			fi
    fi
done

# Launch rofi
wall_selection=$(find "${wall_dir}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) -exec basename {} \; | sort | while read -r A ; do  echo -en "$A\x00icon\x1f""${cacheDir}"/"$A\n" ; done | $rofi_command)

# Set wallpaper
[[ -n "$wall_selection" ]] || exit 1
#feh --no-fehbg --bg-fill "${wall_dir}/${wall_selection}"

swww img "${wall_dir}/${wall_selection}" --transition-fps 75 --transition-type any --transition-duration 2
#swww img "${wall_selection}"

exit 0