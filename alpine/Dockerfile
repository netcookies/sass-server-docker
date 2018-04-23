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
        python2 \
        && rm /bin/sh && ln -s /bin/bash /bin/sh

RUN yarn global add gulp@next \
    && git config --system http.sslverify false

RUN git clone https://github.com/netcookies/sass-server-gulp.git /app \
    && cd /app \
    && rm -rf src/ \
    && rm -rf yarn.lock \
    && yarn install \
    && yarn cache clean

WORKDIR /app/

ENTRYPOINT ["/app/node_modules/gulp/bin/gulp.js"]
