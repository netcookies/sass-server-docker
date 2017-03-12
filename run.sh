#!/bin/sh

git clone https://github.com/netcookies/sass-server-gulp.git

mv public ../
mv src ../

docker build -t sass-server-docker .
