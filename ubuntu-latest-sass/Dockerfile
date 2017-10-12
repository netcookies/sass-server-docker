FROM node

MAINTAINER Andrew Li <andrew.li@hinterlands.com.au>

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
