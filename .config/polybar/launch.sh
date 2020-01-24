#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Find config file
CONFIG=$DIR/config-$(hostname)
if [[ ! -f $CONFIG ]]; then
	CONFIG=$DIR/config-default
fi

# Launch bars
polybar top --config=$CONFIG &
