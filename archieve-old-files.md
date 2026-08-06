# Log Backup & Cleanup Script

This Bash script backs up `.log` files older than 7 days and removes them from the original location.

## Bash script

```bash
#!/bin/bash

# Backup .log files older than 7 days and delete originals

LOG_DIR="/var/log"
ARCHIVE_DIR="/home/ishanga/all-logs"

# create backup dir if not exists
mkdir -p "$ARCHIVE_DIR"

# find, move and clean
sudo find "$LOG_DIR" -type f -name "*.log" -mtime +7 -exec mv {} "$ARCHIVE_DIR" \;

echo "Old logs moved to $ARCHIVE_DIR"
```

## How to run

Save the script as `log-backup.sh`, then run:

```bash
chmod +x log-backup.sh
sudo ./log-backup.sh
```
