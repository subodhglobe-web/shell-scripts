#!/bin/bash


local_user=ishanga
local_srv=192.168.129.125
local_dir=/home/ishanga/scripts


remote_user=root
remote_srv=127.0.0.1
remote_dir=/mnt


#sudo scp -R  "$local_srv":"$local_dir"  "$remote_srv":"$remote_dir"




read -p $'Enter the Site Name :-\n' site_name
read -p $'Enter the time to check (Mins) :-\n' second

(( ttl_time =  second * 60 )) #Convert mins to secs

#Runing the command to get variable of http_status code.

status_code=$(curl -s -o  /dev/null -w  "%{http_code}\n"  "$site_name")
echo ""

if [[ "$status_code" -eq 301 || "$status_code" -eq 200 ]]; then
	echo " "
	ping -c "${ttl_time}"  "${site_name}"	 
else
    echo "Site $site_name is down, please try again later! "


fi    
