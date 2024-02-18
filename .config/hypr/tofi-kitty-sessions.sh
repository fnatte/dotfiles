#!/bin/sh

DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty/sessions"
SELECTED=$(ls -1 "$DIR" | sed 's/\.conf//g' | tofi)

if [ -z "$SELECTED" ]; then
	exit 0
fi

SESSION_NAME="sessions/$SELECTED.conf"

kitty --session "$SESSION_NAME"
