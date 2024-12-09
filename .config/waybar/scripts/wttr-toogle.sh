#!/bin/bash

formats=(
	"1"
	"2"
	"3"
	"4"
	"%c+%t+(%f)"
);

STATE="/tmp/waybar-wttr-format"
current_index=$(cat "$STATE" 2>/dev/null || echo 4)
next_index=$(((current_index + 1) % 5))
echo "$next_index" > "$STATE"
