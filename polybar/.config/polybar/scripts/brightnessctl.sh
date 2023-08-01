#!/bin/bash
BRIGHTNESS_VALUE=`brightnessctl | grep -o "(.*" | tr -d "()"`
BRIGHTNESS_NR=${BRIGHTNESS_VALUE//%}

if [ $BRIGHTNESS_NR -lt 20 ]; then
    BRIGHTNESS_ICON='%{T2} %{T-}'
elif [ $BRIGHTNESS_NR -lt 40 ]; then
    BRIGHTNESS_ICON='%{T2} %{T-}'
elif [ $BRIGHTNESS_NR -lt 60 ]; then
    BRIGHTNESS_ICON='%{T2} %{T-}'
elif [ $BRIGHTNESS_NR -lt 80 ]; then
    BRIGHTNESS_ICON='%{T2} %{T-}'
else
    BRIGHTNESS_ICON='%{T2} %{T-}'
fi

echo "$BRIGHTNESS_ICON $BRIGHTNESS_VALUE"

