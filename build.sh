#!/bin/bash
git pull || exit
v=$(cat VERSION)
new=$(git ls-remote --tags https://github.com/Flexget/Flexget.git | sort -t '/' -k 3 -V | egrep -v "\}" | awk '{print $2}' | cut -d / -f3 | tail -1)
if [ $v != $new ]
then
	echo $new > VERSION
	echo git tag $new
	img=planeturban/docker-flexget-develop
	docker login -u $dhu -p $dhp
	docker build -t $img:$new . 
	docker tag $img:$new $img:latest
	docker push $img
	docker rmi $img:$new $img:latest
	git commit -am "automatic: new version"
fi 
git push
