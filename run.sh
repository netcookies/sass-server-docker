#!/bin/sh

docker run -v `pwd`/public:/app/web/public -v `pwd`/src:/app/web/src sass-server-docker
