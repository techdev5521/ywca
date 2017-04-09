#!/bin/bash

#############################################################################################
# This script is to automatically pull changes down from GitHub and update the live website #
#############################################################################################



##########
# CONFIG #
##########

UPDATE_DIR=/var/www/html/update/
GITHUB_REPO=https://github.com/techdev5521/ywca/archive/



##########
# SCRIPT #
##########

# If UPDATE_DIR does not exist, make it
if [ ! -d "${UPDATE_DIR}" ]; then
	mkdir ${UPDATE_DIR}
fi

# Go to UPDATE_DIR
cd ${UPDATE_DIR}

# Download latest master branch from GITHUB_REPO and save it as git.zip in UPDATE_DIR
wget --quiet -O git.zip ${GITHUB_REPO}master.zip

# Extract the master branch to UPDATE_DIR
unzip -q git.zip

# Remove all existing files in the parent of UPDATE_DIR except UPDATE_DIR
cd ../
rm -rf $(ls | grep -v update)

# Move contents of master branch to UPDATE_DIR parent
cd ${UPDATE_DIR}/ywca-master/
cp -rf $(ls | grep -v -e LICENSE -e README -e TODO) ../../

# Move to UPDATE_DIR parent
cd ../../

# Delete all files in UPDATE_DIR
rm -r ${UPDATE_DIR}/*