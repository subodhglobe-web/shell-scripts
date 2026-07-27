#!/bin/bash


# bash -x debug.sh

#set -x
#ls -l /home/ishanga
#sudo service docker status
#set +x

my_array=(abc1, abc2, abc3, abc4, abc4)

echo ${my_array[0]}

echo ${my_array[4]}
echo ""
echo ""
for i in "${my_array[@]}"; do
	echo $i
done	

cmd="ls -al"

eval $cmd

echo "First Argument: $1"
echo "Second Argument: $@"
echo "Number of Argument: $#"

echo ""
echo ""

VAR="abcdef"
if [ -z "$VAR" ]; then
	echo "$VAR is set"
else
       echo "VAR is  not set"	
fi



while IFS= read -r line; do
	echo "$line"
done < script.sh

echo ""
echo ""

tempfile=$(mktemp)
echo "Soome data" > $tempfile

rm -rf $tempfile

# jq is a tool to use parse json data
#

str="Hello World"
echo ${str:8}
echo ${str:5:7}
echo ${str/World/Subodh!}
echo ${#str}

