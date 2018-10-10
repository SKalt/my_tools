#! /bin/sh
[ !-z $1 ] || TAG="-t $1"
docker build -t skalt/dev-env:latest $TAG .
