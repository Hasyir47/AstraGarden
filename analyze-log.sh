#!/bin/bash

# check argument
if [ $# -eq 0 ]; then
	echo "Usage: $0 <log-file>"
	exit 1
fi

logfile=$1

# check file exists
if [ ! -f "$logfile" ]; then
	echo "Error: File $logfile not found"
	exit 1
fi

echo "======================================"
echo "NGINX LOG ANAYSIS"
echo "======================================"
echo

# Top 5 IP addresses
echo "Top 5 IP addresses with the most request:"
awk '{print $1}' "$logfile" \
| sort \
| uniq -c \
| sort -nr \
| head -5 \
| awk '{print $2 " - " $1 " requests"}'

echo
echo "======================================="
echo


# Top 5 requested paths
echo "Top 5 most requested paths:"
awk -F '"' '{print $2}' "$logfile" \
| awk '{print $2}' \
| sort \
| uniq -c \
| sort -nr \
| head -5 \
| awk '{print $2 " - " $1 " requests" }'

echo
echo "===================================="
echo

# Top 5 response codes 
echo "Top 5 response status codes:"
awk '{print $9}' "$logfile" \
| sort \
| uniq -c \
| sort -nr \
| head -5 \
| awk '{print $2 " - " $1 " requests"}'

echo
echo "==================================="
echo 

# Top 5 user agents
echo "Top 5 user agents:"
awk -F'"' '{print $6}' "$logfile" \
| sort \
| uniq -c \
| sort -nr \
| head -5 \
| awk '{$1=""; print substr($0,2) " - " $1 " requests"}'

echo
echo "===================================="
echo " Analysis Complete"
echo "====================================" 


