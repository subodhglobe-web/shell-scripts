#!/bin/bash

# This script checks whether a service is running.
# If the service is not running, it starts and enables the service.

service="httpd"

# Option 1 

if ! systemctl is-active --quiet "$service"; then
    sudo systemctl enable --now "$service"
    echo "Started and enabled: $service.service"
else
    echo "$service.service is already running."
fi

### Option-2

iif systemctl status "$service" | grep -q "Active: inactive"; then
    sudo systemctl enable --now "$service"
    echo "Started and enabled: $service.service"
fi
