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
repo="$newuser"".git"
home="${PWD}/$repo/"

getent group $projectGroup || groupadd $projectGroup
getent group docker || groupadd docker
git init --bare $repo
useradd -d $home --shell /bin/bash -g $projectGroup $newuser
gpasswd -a $newuser docker

cp run.sh $home
cp gitignore $home/.gitignore
cd $home
mkdir public
mkdir src
git submodule add  https://github.com/netcookies/community-skin.git src/scss
chown -R $newuser:$projectGroup $home

# Create new user and assign random password.

echo $newuser:$randompw | chpasswd
echo "UserID:" $newuser "has been created with the following password:" $randompw
