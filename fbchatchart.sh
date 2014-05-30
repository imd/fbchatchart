#!/bin/bash
NAME=$1
SHIFT=${2-0}
TIMESTAMPS=$(</dev/stdin grep -A1 "$NAME" | grep ":" | cut -c 5-)
DAYS="Mon Tue Wed Thu Fri Sat Sun"
DATA=$(echo "$TIMESTAMPS" | fb-shift-ts.py "$SHIFT")
HOURS=(12 {1..12} {1..11})

printf "   %s\n" "$DAYS"
for hour in {0..23}; do
    zhour=$(printf "%02d" $hour)
    printf "%2d" "${HOURS[$hour]}"
    for day in $DAYS; do
        count=$(echo "$DATA" | sort | uniq -c | grep "$day $zhour" | cut -c1-7 | tr -d ' ')
        if [ -z "$count" ]; then
            printf "    "
        else
            printf " %3d" $count
        fi
    done
    echo
done
