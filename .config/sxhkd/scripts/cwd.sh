#!/bin/bash

ID=$(xdpyinfo | grep focus | cut -f4 -d " ")
ID=${ID::-1}
PID=$(xprop -id $ID | grep -m 1 PID | cut -f3 -d " ")

if [ -n "$PID" ]; then
	TREE=$(pstree -lpA $PID)
	PID=$(echo "$TREE" | grep bash | awk -F'[-\\+]+' '{split($NF, a, "[()]"); print a[2]}')

	if [ -e "/proc/$PID/cwd" ]; then
		CWD=$(readlink /proc/$PID/cwd)
	fi
fi

# echo "$TREE $PID $CWD" > ~/test.txt

if [ -z "$CWD" ]; then
	echo "$HOME"
else
	echo "$CWD"
fi


