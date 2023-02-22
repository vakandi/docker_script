#!/bin/sh

# Create a temporary file to store the extracted IP addresses
tmpFile=$(mktemp)

# Use grep to extract the IP addresses from the log file
grep -Eo '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' /var/log/apache2/access.log > $tmpFile

# Use sort and uniq to get a list of unique IP addresses
sort $tmpFile | uniq

# Remove the temporary file
rm $tmpFile

