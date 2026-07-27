#!/bin/bash

#Create a script to monitor disk usage and send an alert if usage exceeds 80%.

# Variables
FROM_EMAIL="your_email@gmail.com"
TO_EMAIL="recipient@example.com"
APP_PASS="xxxx xxxx xxxx xxxx"  # Your 16-character Google App Password

# Sending via curl SMTP protocol
curl --url 'smtps://smtp.gmail.com:465' \
  --ssl-reqd \
  --mail-from "$FROM_EMAIL" \
  --mail-rcpt "$TO_EMAIL" \
  --user "$FROM_EMAIL:$APP_PASS" \
  -T <(echo -e "From: $FROM_EMAIL\nTo: $TO_EMAIL\nSubject: Test Shell Email\n\nThis is the email body text sent via curl!")







threshold=20

 df -hT -t ext4 -t xfs -t NTFS -t exfat | grep -v 'Filesystem' | awk '{print $1, $6}' | tr -d '%' | awk '$2 > "$threshold"  {print "Warning: " $1 " is at " $2 "%"}'










#!/bin/bash

# 1. Define your threshold limit (in percentage)
threshold=20

# 2. Define the email trigger function
send_warning_email() {
    local drive_name="$1"
    local percentage="$2"
    
    # Configuration variables for your email (Use your Gmail App Password here)
    FROM_EMAIL="your_email@gmail.com"
    TO_EMAIL="recipient@example.com"
    APP_PASS="xxxx xxxx xxxx xxxx" 

    echo "Threshold reached! Sending alert email for $drive_name ($percentage%)..."

    # Native curl SMTP command to send the alert email
    curl -s --url 'smtps://://gmail.com' \
      --ssl-reqd \
      --mail-from "$FROM_EMAIL" \
      --mail-rcpt "$TO_EMAIL" \
      --user "$FROM_EMAIL:$APP_PASS" \
      -T <(echo -e "From: $FROM_EMAIL\nTo: $TO_EMAIL\nSubject: DISK CRITICAL: $drive_name at $percentage%\n\nWarning! The filesystem mounted on $drive_name has reached $percentage% capacity, which exceeds your configured safety threshold of $threshold%.")
}

# 3. Stream disk space directly into a Bash processing loop
df -hT -t ext4 -t xfs -t NTFS -t exfat | grep -v 'Filesystem' | awk '{print $1, $6}' | tr -d '%' | \
while read -r filesystem usage; do
    
    # Compare numeric storage value against threshold
    if [[ "$usage" -gt "$threshold" ]]; then
        # Trigger the function and pass the filesystem metrics as arguments
        send_warning_email "$filesystem" "$usage"
    fi

done
 
