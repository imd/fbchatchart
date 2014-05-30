#!/usr/bin/env python
from datetime import datetime, timedelta
import sys

SHIFT=int(sys.argv[1])
TIMESTAMPS = sys.stdin.readlines()

for timestamp in TIMESTAMPS:
    if ',' not in timestamp:
        timestamp = '{}, {}'.format(datetime.today().strftime("%Y/%m/%d"),
                                    timestamp)
    else:
        timestamp = '{}/{}'.format(datetime.today().strftime("%Y"), timestamp)
    a = datetime.strptime(timestamp, "%Y/%m/%d, %I:%M%p\n")
    b = a + timedelta(hours=SHIFT)
    c = b.strftime("%a %H")
    print c
