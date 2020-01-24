#!/bin/sh

# Use maim if available
if [ -x "$(command -v maim)" ]; then
	maim -s | xclip -selection clipboard -t image/png
	exit 0
fi

# Fallback to import if available
if [ -x "$(command -v import)" ]; then
	import -window root ~/Pictures/$(date '+%Y%m%d-%H%M%S').png
	exit 0
fi

echo "Failed to take screenshot: could not find maim nor import"

exit 1
