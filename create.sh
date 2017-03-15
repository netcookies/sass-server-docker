#!/bin/sh

if [ $# -lt 1 ]; then
    echo "Please give the project name without whitespace."
    echo "e.g. " $0 "project-name"
    echo " "
    echo "This script will do three things:"
    echo "   1. Create a folder contain base scss. "
    echo "   2. Create a login user which can only access this folder."
    echo "   3. Create a docker short-cut call 'run.sh'."
    exit
fi

# Declare local variables, generate random password.

newuser=$1
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
projectGroup="project"

mkdir -p $1
cd $1
mkdir public
mkdir src
cd src
git clone https://github.com/netcookies/community-skin.git scss
cd ..
home=${PWD}

# Create new user and assign random password.

getent group $projectGroup || groupadd $projectGroup
getent group docker || groupadd docker
useradd $newuser --create-home -d $home --shell /bin/bash -g $projectGroup $newuser
gpasswd -a $newuser docker
echo $newuser:$randompw | chpasswd
echo "UserID:" $newuser "has been created with the following password:" $randompw
