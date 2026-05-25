#!/bin/bash

# check argument

if [ $# -eq 0 ]; then 
	echo "Usage: $0 <log-directory>"
	exit 1
fi

log_directory=$1

# check directory exists
if [ ! -d "$log_directory" ]; then
	echo "Error: Directory $log_directory not found"
	exit 1
fi

# Timestamp
timestamp=$(date +"%Y%m%d_%H%M%S")

# Archive directory
archive_dir="./archive"

# Create archive directory if not exist
mkdir -p "$archive_dir"

# Archive filename
archive_name="logs_archive_${timestamp}.tar.gz"

# Compress Logs 
tar -czf "$archive_dir/$archive_name" "$log_directory"

# check tar result
if [ $? -eq 0 ]; then 

	#log activity
	echo "$(date '+%Y-%m-%d %H:%M:%S' ) - Archive created: $archive_name" >> archive.log
	
	echo "Archive successful"
	echo "Location: %archive_dir/$archive_name"

else
	echo "Archive failed"
	exit 1
fi
