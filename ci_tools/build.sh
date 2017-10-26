#!/bin/bash

parent_directory=$(dirname $0)
cd $parent_directory
sh ("pwd")
docker build -t yoba-nodejs-${BUILD_ID} .
