#!/bin/bash


### Go to this link for creating the Google App Password
#### Link ="https://share.google/AxzOqNwrdmt2x2RbO"
#### Provide all the details in the below variables.

FROM_EMAIL="xxxxxxxxxx@gmail.com"
TO_EMAIL="xxxxxxxx@gmail.com123"
APP_PASS="xxxx xxxx xxxx xxxx"
threshold=20

##### This is funtion which shoot the mail with the following details

mail_shoot() {
curl -s --url 'smtps://smtp.gmail.com:465' \
--ssl-reqd \
--mail-from "$FROM_EMAIL" \
--mail-rcpt "$TO_EMAIL" \
--user "$FROM_EMAIL:$APP_PASS" \
-T <(cat)
}

#### df Command is used to check all filesystem and has taken neccesay column data through awk command  
#### and shoot the mail when meet the defined threshold.
 
df -hT -t ext4 -t xfs -t ntfs -t exfat |
grep -v 'Filesystem' |
awk '{print $1, $6}' |
tr -d '%' |
awk -v thres="$threshold" '$2 > thres {print "Warning: " $1 " is at " $2 "%"}' | tee /dev/tty |
(
echo -e "From: $FROM_EMAIL"
echo -e "To: $TO_EMAIL"
echo -e "Subject: Disk Usage Alert"
echo ""
echo "Hello Team,"
echo ""
echo "Disk utilization has crossed the defined threshold. Please take action to extend or add new disks before they are fully utilized."
echo ""
echo "Current Disk Status:"
echo "---------------------"
cat
echo ""
echo "Regards,"
echo "Monitoring System"
)  | mail_shoot


