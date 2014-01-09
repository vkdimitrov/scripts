#!/bin/bash
#public_html folder in production
site='';

#gitosis-admin repo to be skiped
if [ "$1" = "gitosis-admin" ];
then
        continue
else
        #triem stariqt deploy source
        rm -rf /home/git/production/deploy/$1
        mkdir -p /home/git/production/deploy/$1

        cd /home/git/production/repos/
        git clone git@dev.vjsoft.net:$1.git
        cd /home/git/production/repos/$1
        #kopirame samo sorsovete ot master versiqta
        git checkout-index -a -f --prefix=/home/git/production/deploy/$1/
        cd /home/git/production/
        rm -rf /home/git/production/repos/$1
        #setvame env promenlivata @site
        case "$1" in
        factor)
                        site="root@factoring-bg.com:/var/www/factorin-bg.com-deploy"
                        ports='ssh -p11122'
                    ;;
        br3)
                        site="bridgebg@bridge.bg:/home/bridgebg/public_html"
                        ports='ssh -p1022'
                    ;;
        ues)
                        site="uniqp1jx@uniqueestates.net:/home/uniqp1jx/public_html"
                        ports='ssh -p1022'
                    ;;
        sms-reminder)
                        site="bridgebg@bridge.bg:/home/bridgebg/smsreminder.bg"
                        ports='ssh -p1022'
                    ;;
        geograf)
                        site="geografb@geograf.bg:/home/geografb/public_html"
                        ports='ssh -p1022'
                ;;
        ifg)
                        site="ifgleasingssh@ifgleasing.eu:/var/www/clients/client3/web4/test"
                        ports='ssh -p10022'
                    ;;
        voltron)
                        site="vkdimitrov@vladko.org:/home/vkdimitrov/public_html/voltron"
                        ports='ssh -p229'
                    ;;
               *) echo "nqma takova repo" exit
                    ;;
        esac
        /usr/bin/rsync --rsh="$ports" -cruv --size-only --exclude-from="/home/git/production/deploy/$1/.gitignore" --delete-after /home/git/production/deploy/$1/ $site/
fi
