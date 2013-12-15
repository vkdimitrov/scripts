#!/bin/bash

for i in `ls -l $1 |awk '{print $9}'`; 
do
	echo $i
	cd $1/$i/.git
 git fsck --full
done
