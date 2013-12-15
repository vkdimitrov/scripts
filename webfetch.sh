#!/bin/bash
#public_html folder in production
site='';

#gitosis-admin repo to be skiped
if [ "$1" = "gitosis-admin" ];
then
        continue
else
	#triem stariqt deploy source
        rm -rf ../production/deploy/$1
        mkdir -p ../production/deploy/$1
	
        cd /home/git/public_html/dev/$1
	#get branch
	original_branch=`git branch |grep \* |cut -d\* -f2`
	#checkout master 
	git checkout master
	git pull origin master 
        #kopirame samo sorsovete ot master versiqta
	git checkout-index -a -f --prefix=/home/git/production/deploy/$1/
	#checkout original branch
	git checkout $original_branch

	#setvame env promenlivata @site 
        case "$1" in
               	factor)   site="xxxx@xx.xx.xx.xx:/var/www/..."
			  rsync --rsh='ssh -p11122' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
                    ;;
		br3)	site="xxxx@xx.xx.xx.xx:/var/www/..."
			rsync --rsh='ssh -p1022' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
		    ;;
		ues) 	site="xxxx@xx.xx.xx.xx:/var/www/..." 
			rsync --rsh='ssh -p1022' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
		    ;;
		sms-reminder)
			 site="xxxx@xx.xx.xx.xx:/var/www/..."
                        rsync --rsh='ssh -p1022' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
		    ;;
		ifg )
			site="xxxx@xx.xx.xx.xx:/var/www/..."
			rsync --rsh='ssh -p10022' -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
		    ;;
                voltron )   site="voltron.lan"
                    ;;
                *) echo "nqma takova repo" exit
                   ;;
        esac
fi

