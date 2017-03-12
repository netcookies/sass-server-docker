FROM cusspvz/node:latest

EXPOSE 8080 8000 3001
#
# Install gulp, bower, protractor
#
#RUN apk --update add g++ gcc make autoconf git python && \
RUN apk --update add build-base libpng-dev autoconf git python
RUN npm install -g gulp bower
ADD node-sass-build.sh /app/node-sass-build.sh
RUN git config --system http.sslverify false && \
    git clone https://github.com/netcookies/sass-server-gulp.git
RUN cd /app && \
    mkdir -p web/public && \
    mv sass-server-gulp/src/ web/ && \
    ln -s /app/web/public/ sass-server-gulp/public && \
    ln -s /app/web/src/ sass-server-gulp/src
RUN cd /app/sass-server-gulp && npm install && bower install --allow-root

#
# Setup WORKINGDIR so that docker image can be easily tested.
#
RUN apk del git build-base autoconf && \
    rm -fR /var/cache/apk/*;
WORKDIR /app/web/
