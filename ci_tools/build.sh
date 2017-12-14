#!/bin/bash

parent_directory=$(dirname $0)
cd $parent_directory/../${NODEJS_SRC_PATH}
docker build -t yoba-nodejs-${BUILD_ID} .
