#!/bin/bash
NAME=$1
SHIFT=${2-0}
TIMESTAMPS=$(</dev/stdin grep -A1 "$NAME" | grep ":" | cut -c5-)
DAYS="Mon Tue Wed Thu Fri Sat Sun"
SHADES="░▒▓█"
DATA=$(echo "$TIMESTAMPS" | fb-shift-ts.py "$SHIFT")
MAX=$(echo "$DATA" | sort | uniq -c | sort -rn | head -1 | cut -c-7)

for row in {0..1}; do
    printf "    "
    for hour in {00..23}; do
        printf ${hour:$row:1}
    done
    echo
done
for day in $DAYS; do
    printf "$day "
    for hour in {00..23}; do
        count=$(echo "$DATA" | sort | uniq -c | grep "$day $hour" | cut -c1-7 | tr -d ' ')
        if [ -z "$count" ]; then
            printf " "
        else
            i=$(printf "%.0f" $(echo "scale=1; (${#SHADES}-1)*$count/$MAX + 0.5" | bc))
            printf "${SHADES:$i:1}"
        fi
    done
    echo
done
