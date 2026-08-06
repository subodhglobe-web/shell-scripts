# MySQL Backup & Remote Transfer Script

This Bash script takes backup of multiple MySQL databases, compresses it, and copies it to a remote server.

## Bash script

```bash id="mysqlbk"
#!/bin/bash

# MySQL backup and send to remote server

USERNAME="admin"
BACKUP_SERVER="192.168.1.100"

BACKUP_FILE="backup.sql"
ARCHIVE_FILE="backup.sql.tgz"

# take backup
mysqldump -u "$USERNAME" --databases customers_records products prices invoices > "$BACKUP_FILE"

# compress backup
tar -czf "$ARCHIVE_FILE" "$BACKUP_FILE"

# copy to remote server
scp "$ARCHIVE_FILE" root@"$BACKUP_SERVER":/tmp/

# (optional) restore on remote server
ssh root@"$BACKUP_SERVER" <<EOF
cd /tmp
tar -xzf "$ARCHIVE_FILE"
mysql -u root < "$BACKUP_FILE"
rm -f "$BACKUP_FILE" "$ARCHIVE_FILE"
EOF

echo "Backup completed and sent to $BACKUP_SERVER"
```

## Secure credentials

Store MySQL credentials in `~/.my.cnf`:

```bash id="cnfsec"
[client]
user=admin
password=your_password
```

## How to run

Save the script as `mysql-backup.sh`, then run:

```bash id="runbk"
chmod +x mysql-backup.sh
./mysql-backup.sh
```
