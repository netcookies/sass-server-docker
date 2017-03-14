FROM cusspvz/node:latest

MAINTAINER andrew.li@hinterlands.com.au

RUN apk --update add build-base automake autoconf gettext libtool file git python \
    jpeg-dev libpng-dev nasm

RUN npm install -g --silent --progress=false gulp bower && git config --system http.sslverify false

# disable jpegRecompress cause it can not build successful in alpine linux
RUN cd /app && git clone https://github.com/netcookies/sass-server-gulp.git && \
    cd /app/sass-server-gulp && sed -ie 's/zopflipng/jpegRecompress/g' gulpfile.js && \
    rm gulpfile.jse && npm install --silent --progress=false && \
    bower install  --production --silent --config.interactive=false --allow-root

RUN cd /app/sass-server-gulp && \
    npm cache clean && bower cache clean && \
    apk del git gettext libtool file autoconf automake build-base \
    jpeg-dev libpng-dev nasm && \
    rm -fR /var/cache/apk/*;

WORKDIR /app/sass-server-gulp/

ENTRYPOINT ["gulp","--nolocal"]

CMD ["--http"]
