#!/bin/bash
cd /home/git/temp
sudo -u git mkdir $1
cd /home/git/temp/$1
sudo -u git git init .
sudo -u git touch README
echo "INIT" >README
sudo -u git git add /home/git/temp/$1/README
sudo -u git git commit -a -m "init"
sudo -u git git remote add origin git@dev.vjsoft.net:$1.git 
sudo -u git git push origin master
sudo -u git git checkout -b dev
sudo -u git git commit -a -m "dev"
sudo -u git git push origin dev
sudo -u git git checkout -b stage
sudo -u git git commit -a -m "stage"
sudo -u git git push origin stage
rm -r /home/git/temp/$1

# adding hooks
cd /home/git/temp
sudo -u git cp /home/git/temp/post-update /home/git/repositories/$1.git/hooks/

# cloning to dev & stage
cd /home/git/public_html/stage
sudo -u git git clone ../../repositories/$1.git/
cd /home/git/public_html/stage/$1
sudo -u git git checkout stage

cd /home/git/public_html/dev
sudo -u git git clone ../../repositories/$1.git
cd /home/git/public_html/dev/$1
sudo -u git git checkout dev

