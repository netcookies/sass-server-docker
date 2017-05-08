FROM node:alpine

MAINTAINER andrew.li@hinterlands.com.au

RUN apk add --no-cache python=2.7.12-r0 git-perl make gcc g++ bash && rm /bin/sh && ln -s /bin/bash /bin/sh

COPY build-node-sass.sh build.sh

RUN build.sh

RUN yarn global add gulpjs/gulp#4.0 bower && git config --system http.sslverify false

RUN mkdir /app && cd /app && git clone https://github.com/netcookies/sass-server-gulp.git && \
    cd /app/sass-server-gulp && rm -rf src/ && rm -rf yarn.lock && yarn install && \
    bower install --production --silent --config.interactive=false --allow-root

RUN cd /app/sass-server-gulp && \
    yarn cache clean && bower --allow-root cache clean

WORKDIR /app/sass-server-gulp/

ENTRYPOINT ["gulp"]
