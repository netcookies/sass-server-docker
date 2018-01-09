FROM node:alpine

MAINTAINER Andrew Li <andrew.li@hinterlands.com.au>

RUN apk add --update --no-cache \
        gcc \
        g++ \
        make \
        automake \
        alpine-sdk  \
        autoconf  \
        build-base \
        bash \
        git \
        git-perl \
        nasm  \
        zlib \
        zlib-dev \
        libpng \
        libpng-dev\
        libwebp \
        libwebp-dev \
        libjpeg-turbo \
        libjpeg-turbo-dev \
        python=2.7.13-r1 \
        && rm /bin/sh && ln -s /bin/bash /bin/sh

RUN yarn global add gulpjs/gulp \
    && git config --system http.sslverify false

RUN mkdir /app \
    && cd /app \
    && git clone -b latest-node-sass https://github.com/netcookies/sass-server-gulp.git \
    && cd /app/sass-server-gulp \
    && rm -rf src/ \
    && rm -rf yarn.lock \
    && yarn install \
    && cd /app/sass-server-gulp \
    && yarn cache clean

WORKDIR /app/sass-server-gulp/

ENTRYPOINT ["gulp"]
