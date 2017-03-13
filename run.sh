#!/bin/sh

http_port=8080
reserve_proxy_port=8000
admin_port=3001
public_path="$(pwd)/public"
src_path="$(pwd)/src"

mkdir public
mkdir src
cd src
git clone https://github.com/netcookies/community-skin.git scss

docker run -d \
    -p $http_port:8080 \
    -p $reserve_proxy_port:8000 \
    -p $admin_port:3001 \
    -v $public_path:/app/sass-server-gulp/public/ \
    -v $src_path:/app/sass-server-gulp/src/ \
    sass-server-docker
