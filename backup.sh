#!/bin/bash

# want to automate the deployment of an application to multiple servers. How would you achieve this using a shell script

# Write the names of remote-servers in the array.
 
remote_servers=(nodea nodeb ubuntu amazon)
username=root
src=master
dest=$nodes
dir_name="weather_dashboard"
 

for nodes in "${remote_servers[@]}"; do
       echo "Deploying to $nodes"; 


scp -rv    ec2-user@54.224.184.249:/home/ec2-user/"$dir_name"      "$username@$dest:/var/www/html/"   > /home/$username/remote.logs > /tmp/backup.logs 2&1 
 done

