#!/bin/bash

TERMINAL="urxvt"
LOWER=20
UPPER=100

function convert_to_hex {
    printf "%02x" $1
}

function generate_color {
    let color="$LOWER + $RANDOM % ($UPPER - $LOWER)"
    echo `convert_to_hex $color`
}

color_hex="#"
for (( x=0; x<3; ++x )); do
    color_hex=$color_hex$(generate_color)
done

$TERMINAL -bg $color_hex
