#!/bin/bash
#AUTHOR: LUXPROG101
# USING SHODAN FREE INFORMATION
# It's an easy way to get some basic information about a domain IP if you dont have a GUI to go on the official shodan website
# NOT FINISHED YET

# Prompt user for the file name
echo "Please enter the name of the list of IP file:"
read file_name

# Read the IPs from the file
ips=$(cat "$file_name")

# loop through each IP
for ip in $ips
do
    city=$(curl -s https://www.shodan.io/host/$ip | grep "city" | cut -d"%" -f3 | cut -d"2" -f3 | cut -d ";" -f2 | sed '1d' )
    country=$(curl -s https://www.shodan.io/host/$ip | grep "query=country" | cut -d">" -f4 | cut -d"<" -f1)
    organization=$(curl -s https://www.shodan.io/host/$ip | grep "query=org" | cut -d">" -f4 | cut -d"<" -f1)
    ports=$(curl -s https://www.shodan.io/host/$ip | grep "Ports open" | cut -d":" -f3 | cut -d'"' -f1)
    infoport1=$(curl -s https://www.shodan.io/host/$ip |sed -n '/<pre>/,/<\/pre>/p' | sed -n '1,/<\/pre>/p' | sed '1d;$d')    
    echo "IP: $ip"
    echo "CITY: $city"
    echo "COUNTRY: $country"
    echo "ORGANIZATION: $organization"
    echo "OPEN PORTS: $ports"
    echo "First PORT info:"
    echo "$infoport1"
done
