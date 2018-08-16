#!/bin/bash
git ls-remote --tags https://github.com/Flexget/Flexget.git | sort -t '/' -k 3 -V | egrep -v "\}" | awk '{print $2}' | cut -d / -f3 | tail -1
