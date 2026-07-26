#!/bin/bash

### Write a script to back up log files older than 7 days
### and then delete the original files.

log_dir="/var/log"
archive_dir="/home/ishanga/all-logs"

### Type-1

# Create the backup directory if it doesn't exist
mkdir -p "$archive_dir"

# Copy log files older than 7 days and delete the originals
sudo find "$log_dir" -type f -name "*.log" -mtime +7 -exec bash -c '
    cp "$1" "'"$archive_dir"'" && rm -f "$1"
' _ {} \;
### Type-2
sudo find "$log_dir" -type f -mtime +7 -exec mv -t "$archive_dir" {} +

### Type-3
sudo find /var/log -type f -name "*.log" -mtime +7 -exec cp {} "$archive_dir" \;
