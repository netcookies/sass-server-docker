FROM cusspvz/node:latest

EXPOSE 8080 8000 3001
#
# Install gulp, bower, protractor
#
RUN apk --update add g++ gcc make git
RUN npm install -g gulp bower
COPY sass-sever-gulp /app/
COPY node-sass /app/
COPY build-node-sass.sh /app/build-node-sass.sh
RUN cd /app && \
    mkdir -p web/public && \
    mv sass-server-gulp/src/ web/ && \
    ln -s /app/web/public/ sass-server-gulp/public && \
    ln -s /app/web/src/ sass-server-gulp/src
RUN chmod+x node-sass-build.sh && bash node-sass-build.sh
RUN cd ~/sass-server-gulp && npm install && bower install

#
# Setup WORKINGDIR so that docker image can be easily tested.
#
RUN mkdir -p /workPlace && \
    mkdir -p /workPlace/public && \
    mv src/scss /workPlace/ && \
    ln -s /workPlace/public ~/sass-server-gulp/public && \
    mv ~/sass-server-gulp/src /workPlace && \
    ln -s /workPlace/src ~/sass-server-gulp/src
WORKDIR /app/web/
