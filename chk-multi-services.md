# Multi-Service Status Checker

This Bash script checks multiple services and starts any service that is not running.

## Bash script

```bash
#!/bin/bash

services=("mysql" "httpd" "redis")

for service in "${services[@]}"; do
    echo "Checking: $service"

    if ! systemctl is-active --quiet "$service"; then
        systemctl enable --now "$service"
        echo "Service started: $service"
    else
        echo "Service is already running: $service"
    fi
done
```

## How to run

Save the script as `check-services.sh`, then run:

```bash
chmod +x check-services.sh
sudo ./check-services.sh
```
## How to run the script

Save the Bash code as `check-services.sh`, then run:

```bash
chmod +x check-services.sh
sudo ./check-services.sh
```
