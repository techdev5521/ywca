#!/bin/bash

#############################################################################################
# This script is to automatically pull changes down from GitHub and update the live website #
#############################################################################################

##########
# Config #
##########

# Make temp folder to download into
if [ -d /var/www/html/ywca/update]
	then
		mkdir /var/www/html/ywca/update
fi

# Switch to newly made directory
cd /var/www/html/ywca/update/

# Pull latest file from GitHub
wget --quiet -O git.zip https://github.com/techdev5521/ywca/archive/master.zip

# Extract the file
unzip -q git.zip

# Remove existing files
cd /var/www/html/ywca/
rm -rf $(ls | grep -v update)

# Move new files over
cd /var/www/html/ywca/update/ywca-master/
cp -rf $(ls | grep -v -e LICENSE -e README -e TODO -e utils) /var/www/html/ywca/

# Move to web root
cd /var/www/html/ywca

# Cleanup
rm -r update/