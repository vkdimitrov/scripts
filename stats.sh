#!/bin/bash
echo "">/var/www/stats
w|head -1 >>/var/www/stats
echo "__________________________________________">>/var/www/stats
less /proc/cpuinfo |grep model\ name |cut -d: -f2 >>/var/www/stats
sensors |tail -3|awk {'print($1,$2,$3)'} >>/var/www/stats
echo "__________________________________________">>/var/www/stats
free -ho >>/var/www/stats
echo " ">>/var/www/stats
