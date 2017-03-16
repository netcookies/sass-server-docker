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
userGroup="project"
randompw=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
projectName=$newuser
projectFolder="${PWD}/project/$projectName"
home="${PWD}/bare/"
repo="$projectName"".git"
bareRepo=$home"/"$projectName".git"
gitMail=$newuser"@hinterlands.bot"

getent group $userGroup || groupadd $userGroup
getent group docker || groupadd docker

cd $home
git init --bare $repo
useradd -d $home --shell /bin/bash -g $userGroup $newuser
gpasswd -a $newuser docker
chown -R $newuser:$userGroup $bareRepo

git clone $bareRepo $projectFolder
cp run.sh $projectFolder
cp gitignore $projectFolder/.gitignore
cd $projectFolder
git config user.email $gitMail
git config user.name $newuser
git config push.default simple
git submodule add https://github.com/netcookies/community-skin.git src/scss
mkdir public
git add --all
git commit -am "init"
git push

# Create new user and assign random password.

echo $newuser:$randompw | chpasswd
echo "UserID:" $newuser "has been created with the following password:" $randompw
