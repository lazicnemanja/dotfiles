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

format="${formats[$current_index]}"
curl wttr.in/novi-sad?format="$format"
