#!/bin/sh

docker run -v ./public:/app/web/public -v ./src:/app/web/src sass-server-docker
