#!/bin/bash

#This script create /forcefsck file and reboots the system.
#In that way filesystem check will be run on boot.

touch /forcefsck
reboot