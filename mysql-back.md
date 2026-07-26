#!/bin/bash

### Create a script to automate a MySQL database backup and copy it to a remote backup server.

username="your_username"
password="your_password"
database_name="your_database"
backup_server="192.168.1.100"

backup_file="backup.sql"
archive_file="backup.sql.tgz"

### Create the database backup
mysqldump -u "$username" -p"$password" "$database_name" > "$backup_file"

### Compress the backup
tar -czf "$archive_file" "$backup_file"

### Copy the archive to the backup server
scp "$archive_file" root@"$backup_server":/tmp/

### (Optional) Restore the backup on the remote server
ssh root@"$backup_server" <<EOF

cd /tmp

tar -xzf "$archive_file"

mysql -u root -p "$database_name" < "$backup_file"

rm -f "$backup_file" "$archive_file"

EOF
