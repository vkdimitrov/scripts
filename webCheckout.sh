#!/bin/bash

if [ "$1" = "dev" ]
then
	if [ "$2" = "gitosis-admin" ]
	then
		continue
	else
		cd /home/git/public_html/dev/$2
		git checkout $3 
	fi
else
        if [ "$2" = "gitosis-admin" ]
        then
                continue
        else
                cd /home/git/public_html/stage/$2
                git checkout $3
        fi
fi
