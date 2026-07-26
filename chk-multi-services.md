#!/bin/bash

### Used array here for check the multi services. 
  
services=("mysql" "httpd" "redis")

 ### Used loop to check each elements in the array & run the service if it is not running. 
for service in "${services[@]}"; do
    echo "Checking: $service"

    if ! systemctl is-active --quiet "$service"; then
        systemctl enable --now "$service"
        echo "Service started: $service"
    else
        echo "Service is already running: $service"
    fi
done
