#!/bin/sh

git clone https://github.com/netcookies/sass-server-gulp.git

mkdir public
mv sass-server-gulp/src .

docker build -t sass-server-docker .

rm -rf sass-server-gulp
