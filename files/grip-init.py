#!/usr/bin/env python3

import os
import sys
directory = os.path.join(os.getcwd(), '.grip')

if not os.path.exists(directory):
    os.mkdir('.grip')
    print('Initialized empty grip repository in .grip')
else:
    print('grip-init: error: .grip already exists',file=sys.stderr)
    sys.exit(1)