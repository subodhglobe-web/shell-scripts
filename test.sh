#!/bin/bash

services=("mysql" "httpd" "redis") 
for service in "${services[@]}"; 
  do echo "Checking: $service" 
	  if ! systemctl is-active --quiet "$service"; then 
		  systemctl enable --now "$service" 
		  echo "Service started: $service" 
	         else 
		  echo "Service is already running: $service" 
		  fi 
done
