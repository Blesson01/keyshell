#!/bin/bash

echo "Branch : ${GIT_BRANCH}"


echo "Installing Dependencies...."
#npm install || exit 1

echo "Removing old builds"
rm -rvf dist/*

#echo "ng install"
#npm install -g @angular/cli

echo "Building Applictions"
ng build --base-href / || exit 1

echo "Dropping old apps from EC2"
ssh bznode@54.166.151.240 'sudo rm -rvf /var/www/keyshel/*'

#setfacl -Rm u:bznode:rwx /var/www/keyshel/

echo "Rsync build"
rsync -avzP dist/keyshell/* bznode@54.166.151.240:/var/www/keyshel/

if [ $? = 0 ];
        then
	echo "Deployed the App Successfully"
	fi
