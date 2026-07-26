#!/bin/bash

#Write a script to check if a service is running, and start it if it’s not.


service=httpd



#if ! systemctl is-active $service; then 
#         sudo systemctl enable --now $service;
#         echo "Started and Enabled: "$service".service" 
#else
          $service is Already stated"

#fi

if systemctl status "$service" | grep -q "Active:" == "inactive"; then  systemctl enable --now $service echo "Started & Enabled:-" $service 

fi	

