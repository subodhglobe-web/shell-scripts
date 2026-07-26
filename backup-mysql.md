#!/bin/bash

### Automate MySQL database backup and copy it to a remote server.

username="admin"
backup_server="192.168.1.100"

backup_file="backup.sql"
archive_file="backup.sql.tgz"

### Backup multiple databases
mysqldump -u "$username" \
  --databases customers_records products prices invoices \
  > "$backup_file"

### Compress the backup
tar -czf "$archive_file" "$backup_file"

### Copy the archive to the remote backup server
scp "$archive_file" root@"$backup_server":/tmp/

### (Optional) Restore the backup on the remote server
ssh root@"$backup_server" <<EOF
cd /tmp

tar -xzf "$archive_file"

mysql -u root < "$backup_file"

rm -f "$backup_file" "$archive_file"
EOF

## To make the script more secure, I stored the MySQL credentials in ~/.my.cnf instead of embedding the password in the script:

[client]
user=admin
password=your_password

EOF
