# Disk Usage Email Alert

This Bash script checks filesystem usage and sends an email alert when disk utilization crosses the configured threshold.

## Create a Google App Password

Create a Google App Password from your Google Account security settings:

[Create a Google App Password](https://share.google/AxzOqNwrdmt2x2RbO)

Do not use your normal Gmail password. Store the App Password securely and never publish it in a public GitHub repository.

## Configuration

Update the following variables in the script:

- `FROM_EMAIL`: Gmail account used to send the alert.
- `TO_EMAIL`: Email address that receives the alert.
- `APP_PASS`: Gmail App Password.
- `threshold`: Disk-usage percentage that triggers the alert.

## Bash script

```bash
#!/bin/bash

# Gmail account used to send the alert
FROM_EMAIL="sender@example.com"

# Email address that receives the alert
TO_EMAIL="receiver@example.com"

# Use a Google App Password, not your normal Gmail password.
# Never commit a real App Password to GitHub.
APP_PASS="xxxx xxxx xxxx xxxx"

# Send an alert when disk usage exceeds this percentage
threshold=20

# Send the email through Gmail SMTP
mail_shoot() {
    curl -s \
        --url "smtps://smtp.gmail.com:465" \
        --ssl-reqd \
        --mail-from "$FROM_EMAIL" \
        --mail-rcpt "$TO_EMAIL" \
        --user "$FROM_EMAIL:$APP_PASS" \
        -T <(cat)
}

# Check supported filesystems and select the filesystem and usage columns.
# Send an email when disk usage exceeds the configured threshold.
df -hT -t ext4 -t xfs -t ntfs -t exfat |
    grep -v 'Filesystem' |
    awk '{print $1, $6}' |
    tr -d '%' |
    awk -v thres="$threshold" \
        '$2 > thres {print "Warning: " $1 " is at " $2 "%"}' |
    tee /dev/tty |
    (
        echo "From: $FROM_EMAIL"
        echo "To: $TO_EMAIL"
        echo "Subject: Disk Usage Alert"
        echo
        echo "Hello Team,"
        echo
        echo "Disk utilization has crossed the defined threshold."
        echo "Please take action to extend or add new disks before they are fully utilized."
        echo
        echo "Current Disk Status:"
        echo "---------------------"
        cat
        echo
        echo "Regards,"
        echo "Monitoring System"
    ) | mail_shoot
```

## Required packages

Install `curl` before running the script:

```bash
sudo apt update
sudo apt install -y curl
```

## Save and run the script

Save the actual Bash code as `disk-usage-alert.sh`:

```bash
chmod +x disk-usage-alert.sh
./disk-usage-alert.sh
```

If it needs elevated permission to read all filesystems, run:

```bash
sudo ./disk-usage-alert.sh
```

## Security warning

Do not commit credentials like this:

```bash
APP_PASS="real-google-app-password"
```

For a safer setup, provide the values through environment variables:

```bash
export FROM_EMAIL="sender@example.com"
export TO_EMAIL="receiver@example.com"
export APP_PASS="xxxx xxxx xxxx xxxx"
```

Then change the script configuration to:

```bash
FROM_EMAIL="${FROM_EMAIL:?FROM_EMAIL is not set}"
TO_EMAIL="${TO_EMAIL:?TO_EMAIL is not set}"
APP_PASS="${APP_PASS:?APP_PASS is not set}"
```
