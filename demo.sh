#!/bin/bash

echo ""

ls /home/ &> /dev/null


if [ $? -eq  0 ]; then
  echo "   Command executed successfully run"
else
  echo "Command executed not successfully."	
fi
 
echo ""
ls /mnts 2> /dev/null

if [ $? -eq 0 ]; then
  echo " Command executed successfully"
else
  echo "Command executed not successfully."     
fi
	

trap 'echo "Signal received, cleaning up..."; cleanup_function; exit' SIGINT SIGTERM 

cleanup_function() {
	echo "Performing cleanup tasks"

 }

echo "Running script. Press Ctrl+c to test signal trapping."
while true;
  do sleep 1;
  done	  
