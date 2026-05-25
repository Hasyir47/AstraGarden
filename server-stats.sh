#!/bin/bash

echo "======================================"
echo "       SERVER PERFORMANCE STATS       "
echo "======================================"

echo 

# Hostname
echo "Hostname: $(hostname)"

# OS Version

echo "OS Version:"
cat /etc/os-release | grep PRETTY_NAME | cut -d= -f2 | tr -d '"'
echo

# Uptime
echo "Uptime:"
uptime -p
echo

# Load Average
echo "Load Average:"
uptime | awk -F'load average' '{ print $2 }'
echo

# CPU Usage
echo "==================================="
echo "Total CPU Usage"
echo "==================================="

cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100-$8"%"}')

echo "CPU Usage : $cpu_usage"
echo

#Memory Usage
echo "==================================="
echo "Memory Usage"
echo "==================================="

read total used free <<< $(free -m | awk '/Mem:/ {print $2,$3,$4}')

memory_percent=$(awk "BEGIN {printf \"%.2f\", ($used/$total)*100}")

echo "Total Memory  : ${total} MB"
echo "Used Memory   : ${used} MB"
echo "Free Memory   : ${free} MB"
echo "Usage         : ${memory_percent}%"
echo


# Disk Usage
echo "================================="
echo "Disk Usage"
echo "================================="

df -h --total | grep total | awk '
{
print "Total Size : " $2
print "Used Space : " $3
print "Free Space : " $4
print "Usage      : " $5
}'
echo

# Top 5 CPU processes
echo "================================="
echo "Top 5 Processes by CPU"
echo "================================="

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -6
echo

# Top 5 Memory processes
echo "================================="
echo "Top 5 Processes by Memory"
echo "================================="

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -6

#logged in users
echo "================================="
echo "Logged in Users"
echo "================================="

who 
echo


#Failed Login attempts
echo "=================================="
echo " Failed Login Attempts"
echo "=================================="

grep "Failed password" /var/log/secure 2>/dev/null | tail -5

grep "Failed pasword" /var/log/auth.log 2>/dev/null | tail -5

echo
echo "=================================="
echo "Report Complete"
echo "=================================="





