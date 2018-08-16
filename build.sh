#!/bin/bash
git pull || exit
v=$(cat VERSION)
new=$(git ls-remote --tags https://github.com/Flexget/Flexget.git | sort -t '/' -k 3 -V | egrep -v "\}" | awk '{print $2}' | cut -d / -f3 | tail -1)
if [ $v != $new ]
then
	img=planeturban/docker-flexget-develop
	docker login -u $dhu -p $dhp && docker build --no-cache -t $img:$new . && docker tag $img:$new $img:latest && docker push $img && echo $new > VERSION && git tag $new ; git commit VERSION -m "automatic: new version"; git push
fi 
