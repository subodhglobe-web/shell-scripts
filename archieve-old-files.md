#!/bin/bash

# ==========================================
# Script: Log Backup & Cleanup
# Description:
#   - Backup log files older than 7 days
#   - Delete original files after backup
# ==========================================

log_dir="/var/log"
archive_dir="/home/ishanga/all-logs"

# Create archive directory if it doesn't exist
mkdir -p "$archive_dir"

echo "Starting log backup process..."

# -------------------------------
# Method 1: Copy + Delete
# -------------------------------
echo "Method 1: Copy and remove old logs"

sudo find "$log_dir" -type f -name "*.log" -mtime +7 -exec bash -c '
  file="$1"
  archive_dir="$2"
  cp "$file" "$archive_dir" && rm -f "$file"
' _ {} "$archive_dir" \;

# -------------------------------
# Method 2: Move files directly
# -------------------------------
echo "Method 2: Move old logs"

sudo find "$log_dir" -type f -name "*.log" -mtime +7 -exec mv -t "$archive_dir" {} +

# -------------------------------
# Method 3: Only Copy (No Delete)
# -------------------------------
echo "Method 3: Copy only (no delete)"

sudo find "$log_dir" -type f -name "*.log" -mtime +7 -exec cp {} "$archive_dir" \;

echo "Log backup process completed."
