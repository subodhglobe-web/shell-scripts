#!/bin/bash

# Notes:- 
#
# ssh username@remote_ip 'bash -s' < local_script.sh

echo ""

printf "\t\tMEMORY DETAILS\n\n"

free -h | awk ' NR==1 {print "METRIC", "TOTAL", "USED", "FREE", "AVAILABLE"}
NR==2 {print "Mem:", $2, $3,$4,$7} NR==3 {print "Swap:", $2,$3,$4,"N/A"}' | column -t

echo ""
sudo yum -y -q install sysstat -y
echo""

printf "\t\tPROCESSOR / CORES USES\n\n"


lscpu | grep "Thread(s) per core:"
lscpu | grep "Core(s) per socket:"

echo ""
echo ""

mpstat -P ALL | awk '
NR==1 { 
    gsub(/[()]/, "", $3); gsub(/[()]/, "", $6); cores=$6; 
    print "Kernel_Version", $2, "Cores:", cores, "System_Name:", $3, "Date:", $4, "\n" 
} 
NR==3 { 
    print "Time", "CPU", "%usr", "%sys", "%dle", "\n" 
}
# Start at line 6 (first core) and loop dynamically until all cores are printed
NR>=6 && NR<(6+cores) { 
    # This automatically loops and prints for 4, 8, or any number of cores
    print $1, $4, $9, $14 , $7 
}' | column -t


echo ""

printf "\t\tNETWORK CONNECTIONS DETAILS\n\n"

echo ""
raw_data=$(nmcli dev show)

echo "$raw_data" | awk -v RS="" '
{
    split($0, lines, "\n")

    # Check only the second line array element for the required types
    if (lines[2] ~ /GENERAL\.TYPE:[[:space:]]*(ethernet|wifi|eth|wif)/) {

        # Extract and print only the requested GENERAL and IP4 fields
        for (i=1; i<=length(lines); i++) {
            if (lines[i] ~ /^(GENERAL\.(CONNECTION|DEVICE|TYPE)|IP4\.(ADDRESS\[1\]|GATEWAY|ROUTE\[1\]|ROUTE\[2\]|DNS\[1\])):/) {
                print lines[i]
            }
        }
        print "" # Keep a clean line gap between different device blocks
    }
}'

echo ""
printf "\t\tHARD DISK DETAILS\n\n"

echo ""

lsblk -o NAME,SIZE,FSUSED,FSAVAIL,FSUSE%,TYPE,MOUNTPOINTS | sed '1s/FSUSED/USED/; 1s/FSAVAIL/AVAILABLE/; 1s/FSUSE%/USED%/'
echo  ""


