FROM node

MAINTAINER Andrew Li <andrew.li@hinterlands.com.au>

RUN git config --system http.sslverify false \
    && git clone https://github.com/netcookies/sass-server-gulp.git app \
    && cd /app \
    && rm -rf src/ \
    && rm -rf yarn.lock \
    && yarn install \
    && yarn cache clean \
    && ln -s /app/node_modules/gulp/bin/gulp.js /usr/local/bin/gulp

WORKDIR /app/

ENTRYPOINT ["gulp"]
