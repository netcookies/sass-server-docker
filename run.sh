#!/bin/sh

git clone https://github.com/netcookies/sass-server-gulp.git

mv sass-server-gulp/public .
mv sass-server-gulp/src .

docker build -t sass-server-docker .
