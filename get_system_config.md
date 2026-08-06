# System Health Monitoring Script

This Bash script checks memory, CPU usage, network info, and disk details in a clean format.

## Bash script

```bash id="sysmon2"
#!/bin/bash

echo ""

# MEMORY DETAILS
printf "\t\tMEMORY DETAILS\n\n"

free -h | awk '
NR==1 {print "METRIC", "TOTAL", "USED", "FREE", "AVAILABLE"}
NR==2 {print "Mem:", $2, $3, $4, $7}
NR==3 {print "Swap:", $2, $3, $4, "N/A"}
' | column -t

echo ""

# install sysstat (for mpstat)
sudo yum -y -q install sysstat

echo ""

# CPU DETAILS
printf "\t\tPROCESSOR / CORES UTILIZATION\n\n"

lscpu | grep "Thread(s) per core:"
lscpu | grep "Core(s) per socket:"

echo ""

mpstat -P ALL | awk '
NR==1 {
gsub(/[()]/, "", $3); gsub(/[()]/, "", $6); cores=$6;
print "Kernel:", $2, "Cores:", cores, "Host:", $3, "Date:", $4, "\n"
}
NR==3 {
print "Time", "CPU", "%usr", "%sys", "%idle", "\n"
}
NR>=6 && NR<(6+cores) {
print $1, $4, $9, $14, $7
}' | column -t

echo ""

# NETWORK DETAILS
printf "\t\tNETWORK DETAILS\n\n"

nmcli dev show | awk -v RS="" '
{
split($0, lines, "\n")
if (lines[2] ~ /GENERAL\.TYPE:[[:space:]]*(ethernet|wifi)/) {
    for (i=1; i<=length(lines); i++) {
        if (lines[i] ~ /^(GENERAL\.(CONNECTION|DEVICE|TYPE)|IP4\.(ADDRESS\[1\]|GATEWAY|DNS\[1\])):/) {
            print lines[i]
        }
    }
    print ""
}
}'

echo ""

# DISK DETAILS
printf "\t\tDISK DETAILS\n\n"

lsblk -o NAME,SIZE,FSUSED,FSAVAIL,FSUSE%,TYPE,MOUNTPOINTS \
| sed '1s/FSUSED/USED/;1s/FSAVAIL/AVAILABLE/;1s/FSUSE%/USED%/'

echo ""
```

## How to run

Save the script as `system-monitor.sh`, then run:

```bash id="runsys2"
chmod +x system-monitor.sh
./system-monitor.sh
```

## Run on remote server

You can execute this script on a remote server using:

```bash id="remotesys"
ssh username@remote_ip 'bash -s' < system-monitor.sh
```
