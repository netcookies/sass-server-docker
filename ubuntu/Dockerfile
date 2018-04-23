FROM node

MAINTAINER Andrew Li <andrew.li@hinterlands.com.au>

RUN git config --system http.sslverify false \
    && git clone https://github.com/netcookies/sass-server-gulp.git app \
    && cd /app \
    && rm -rf src/ \
    && rm -rf yarn.lock \
    && yarn install \
    && yarn cache clean

WORKDIR /app/

ENTRYPOINT ["/app/node_modules/gulp/bin/gulp.js"]

