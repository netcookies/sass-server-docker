FROM cusspvz/node:latest

EXPOSE 8080 8000 3001
#
# Install gulp, bower, protractor
#
RUN apk --update add build-base libpng-dev autoconf git python
RUN npm install -g gulp bower && \
    git config --system http.sslverify false
ADD sass-server-gulp /app/sass-server-gulp
RUN cd /app && \
    mkdir -p web/public && \
    mkdir -p web/src && \
    ln -s /app/web/public/ sass-server-gulp/public && \
    ln -s /app/web/src/ sass-server-gulp/src
RUN cd /app/sass-server-gulp && npm install && bower install --allow-root
#
# Setup WORKINGDIR so that docker image can be easily tested.
#
RUN apk del git build-base autoconf libpng-dev && \
    rm -fR /var/cache/apk/*;
WORKDIR /app/web/
