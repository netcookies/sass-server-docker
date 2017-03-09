FROM debian:jessie

EXPOSE 8080 8000 3001
# Replace sources.list with 163's sources.list
#RUN mv /etc/apt/sources.list /etc/apt/sources.list.bak && \
    #echo 'deb http://mirrors.163.com/debian/ jessie main non-free contrib' >> /etc/apt/sources.list && \
    #echo 'deb http://mirrors.163.com/debian/ jessie-updates main non-free contrib' >> /etc/apt/sources.list && \
    #echo 'deb http://mirrors.163.com/debian/ jessie-backports main non-free contrib' >> /etc/apt/sources.list && \
    #echo 'deb-src http://mirrors.163.com/debian/ jessie main non-free contrib' >> /etc/apt/sources.list && \
    #echo 'deb-src http://mirrors.163.com/debian/ jessie-updates main non-free contrib' >> /etc/apt/sources.list && \
    #echo 'deb-src http://mirrors.163.com/debian/ jessie-backports main non-free contrib' >> /etc/apt/sources.list && \
    #echo 'deb http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib' >> /etc/apt/sources.list && \
    #echo 'deb-src http://mirrors.163.com/debian-security/ jessie/updates main non-free contrib' >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y curl
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y software-properties-common git nodejs

#
# Install gulp, bower, protractor
#
RUN npm install -g gulp bower
RUN cd ~ && git clone https://github.com/netcookies/sass-server-gulp.git
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
ADD . workPlace
WORKDIR workPlace
