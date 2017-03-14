FROM node

MAINTAINER andrew.li@hinterlands.com.au

RUN yarn global add gulpjs/gulp#4.0 bower && git config --system http.sslverify false

# disable jpegRecompress cause it can not build successful in alpine linux
RUN mkdir /app && cd /app && git clone https://github.com/netcookies/sass-server-gulp.git && \
    cd /app/sass-server-gulp && sed -ie 's/zopflipng/jpegRecompress/g' gulpfile.js && \
    rm gulpfile.jse && rm -rf yarn.lock && yarn install && \
    bower install  --production --silent --config.interactive=false --allow-root

RUN cd /app/sass-server-gulp && \
    yarn clean && yarn cache clean && bower --allow-root cache clean

WORKDIR /app/sass-server-gulp/

ENTRYPOINT ["gulp","--nolocal"]

CMD ["--http"]
