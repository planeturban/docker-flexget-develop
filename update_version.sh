#!/bin/bash
git pull || exit
v=$(cat VERSION)
new=$(git ls-remote --tags https://github.com/Flexget/Flexget.git | sort -t '/' -k 3 -V | egrep -v "\}" | awk '{print $2}' | cut -d / -f3 | tail -1)
if [ $v != $new ]
then
echo $new > VERSION
fi 
git commit -am "automatic: new version"
