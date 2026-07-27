#!/bin/bash






# Write a script to backup logs older than 7 days and delete the original files.
sudo find /var/log/  -type f  -mtime +7 -exec bash -c 'cp  "$1"  all-logs/ && rm -rf "$1"' _ {} \;

sudo find /var/log/  -type f  -mtime +7 -exec mv  {} all-logs  \;


log_dir=/var/log
archive_dir=/home/ishanga/


sudo find /var/log -type f -name "*.log" -mtime +7 -exec cp  {} "$archive_dir" \;
