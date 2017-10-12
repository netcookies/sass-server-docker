FROM node:alpine

MAINTAINER Andrew Li <andrew.li@hinterlands.com.au>

RUN apk add --no-cache python=2.7.13-r1 git-perl make gcc g++ bash && rm /bin/sh && ln -s /bin/bash /bin/sh

RUN yarn global add gulpjs/gulp#4.0 \
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
