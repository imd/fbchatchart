#!/bin/bash
NAME=$1
SHIFT=${2-0}
TIMESTAMPS=$(</dev/stdin grep -A1 "$NAME" | grep ":" | cut -c 5-)
DAYS="Mon Tue Wed Thu Fri Sat Sun"
DATA=$(echo "$TIMESTAMPS" | fb-shift-ts.py "$SHIFT")

printf "   %s\n" "$DAYS"
for hour in {00..23}; do
    printf $hour
    for day in $DAYS; do
        count=$(echo "$DATA" | sort | uniq -c | grep "$day $hour" | cut -c1-7 | tr -d ' ')
        if [ -z "$count" ]; then
            printf "    "
        else
            printf " %3d" $count
        fi
    done
    echo
done
