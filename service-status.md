# Service Status Checker Script

This Bash script checks if a service is running. If not, it starts and enables the service.

## Bash script

```bash id="svcchk"
#!/bin/bash

# check and start service if not running

SERVICE="httpd"

# Option 1 (recommended)
if ! systemctl is-active --quiet "$SERVICE"; then
    sudo systemctl enable --now "$SERVICE"
    echo "Started and enabled: $SERVICE.service"
else
    echo "$SERVICE.service is already running."
fi

# Option 2 (alternative)
if systemctl status "$SERVICE" | grep -q "Active: inactive"; then
    sudo systemctl enable --now "$SERVICE"
    echo "Started and enabled: $SERVICE.service"
fi
```

## How to run

Save the script as `service-check.sh`, then run:

```bash id="runsvc"
chmod +x service-check.sh
sudo ./service-check.sh
```
