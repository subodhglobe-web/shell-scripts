#!/bin/bash

#Create a script to automate database backup.

username=
password=
database_name= 
backup_server=



mysqldump -u "$user_name"   -p"$password"  $database  > backup.sql

tar -czvf backup.sql.tgz   backup.sql


scp backup.sql.tgz root@"{$backup_server}":/tmp/

ssh root@backup_server << 'EOF'

cd /tmp 

tar -xvf /tmp/backup.sql

mysqldump -u root -p < backup.sql  

rm -rf /tmp/{backup.sql.tgz, backup.sql} 


EOF

