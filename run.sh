#!/bin/sh

git clone https://github.com/netcookies/sass-server-gulp.git

git clone --recursive https://github.com/sass/node-sass.git

cd node-sass
git checkout master
git submodule update --init --recursive

cd ..
docker build -t sass-server-docker .
