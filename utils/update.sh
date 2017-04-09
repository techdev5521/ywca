#!/bin/bash

#############################################################################################
# This script is to automatically pull changes down from GitHub and update the live website #
#############################################################################################



##########
# CONFIG #
##########

UPDATE_DIR=/var/www/html/update/
GITHUB_REPO=https://github.com/techdev5521/ywca/archive/

#
# Colors
#

ERROR="\e[31m"
SUCCESS="\e[92m"
INFO="\e[93m"
RESET="\e[0m"



##########
# SCRIPT #
##########

# If UPDATE_DIR does not exist, make it

echo "Check to see if "${UPDATE_DIR}" exists."

if [ ! -d "${UPDATE_DIR}" ]; then
	echo -e ${INFO}${UPDATE_DIR}" does not exist. Making directory."${RESET}
	echo
	mkdir ${UPDATE_DIR}
else
	echo -e ${INFO}${UPDATE_DIR}" already exists. Skipping creation."${RESET}
	echo
fi

# Go to UPDATE_DIR
cd ${UPDATE_DIR}

# Download latest master branch from GITHUB_REPO and save it as git.zip in UPDATE_DIR
echo "Dowloading latest master branch from "${GITHUB_REPO}
wget --quiet -O git.zip ${GITHUB_REPO}master.zip
if [ -a git.zip ]; then
	echo -e ${SUCCESS}"Done."${RESET}
	echo
else
	echo -e ${ERROR}"Unable to download latest master branch from "${GITHUB_REPO}${RESET}
	echo
	exit 1
fi

# Extract the master branch to UPDATE_DIR
PRECOUNT=$(ls -1q | wc -l)
echo "Extracting git.zip into "${UPDATE_DIR}
unzip -q git.zip
if [ $(ls -1q | wc -l) -gt ${PRECOUNT} ]; then
	echo -e ${SUCCESS}"Done."${RESET}
	echo
else
	echo -e ${ERROR}"Unable to extract git.zip. Exiting."${RESET}
	echo
	exit 1
fi


# Remove all existing files in the parent of UPDATE_DIR except UPDATE_DIR
echo "Removing files in "$(cd ../ && pwd)
cd ../
PRECOUNT=$(ls -1q | wc -l)
rm -rf $(ls | grep -v update)
if [ $(ls -1q | wc -l) -le ${PRECOUNT} ]; then
	echo -e ${SUCCESS}"Done."${RESET}
	echo
else
	echo -e ${ERROR}"Unable to remove files in "$(pwd)${RESET}
	exit 1
fi


# Move contents of master branch to UPDATE_DIR parent
echo "Updating files in "$(pwd)
PRECOUNT=$(ls -1q | wc -l)
cd ${UPDATE_DIR}/ywca-master/
cp -rf $(ls | grep -v -e LICENSE -e README -e TODO -e utils) ../../
if [ $(cd ../../ && ls -1q | wc -l) -gt ${PRECOUNT} ]; then
	echo -e ${SUCCESS}"Done."${RESET}
	echo
else
	echo -e ${ERROR}"Unable to move update files in"$(cd ../../ && pwd)${RESET}
	echo
	exit 1
fi

# Move to UPDATE_DIR parent
cd ../../

# Delete all files in UPDATE_DIR
echo "Cleaning up."
rm -r ${UPDATE_DIR}/*
if [ $(cd ${UPDATE_DIR} && ls -1q | wc -l) -gt 0 ]; then
	echo -e ${ERROR}"Unable to remove files from "${UPDATE_DIR}${RESET}
	echo
else
	echo -e ${SUCCESS}"Done."${RESET}
	echo
fi

echo
