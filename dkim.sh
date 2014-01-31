#!/bin/bash
mkdir /etc/opendkim/$1
chmod 700 /etc/opendkim/$1
chown opendkim:opendkim /etc/opendkim/$1
cd /etc/opendkim/$1
opendkim-genkey -t -s mail -d $1
mv mail.private mail
chown opendkim:opendkim mail mail.txt
chmod u=rw,go-rwx mail mail.txt
echo $1" $1:mail:/etc/opendkim/$1/mail">>/etc/opendkim/KeyTable
echo "*@$1          $1">>/etc/opendkim/SigningTable

cat /etc/opendkim/$1/mail.txt
/etc/init.d/opendkim restart
