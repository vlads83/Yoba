#!/bin/bash

parent_directory=$(dirname $0)

if [ -z "${SERVICE_NAME}" ] || [ -z "${VERSION_NUMBER}" ] || [ -z "${ENVIRONMENT_TYPE}" ] ; then
	echo "unable to get SERVICE_NAME or VERSION_NUMBER or ENVIRONMENT_TYPE"
	exit 1
fi

which docker 2>&1

if [ $? -ne 0 ] ; then
	echo "Cannot run the docker build step"
	exit 2
else
	pushd $parent_directory/..

	eval sudo $(aws ecr get-login --no-include-email --region us-east-2) || exit 3
	docker tag ${SERVICE_NAME} ${ECR_URL}/${SERVICE_NAME}:latest && \
	docker push ${ECR_URL}/${SERVICE_NAME}:latest  && \

	docker tag ${SERVICE_NAME} ${ECR_URL}/${SERVICE_NAME}:${ENVIRONMENT_TYPE}  && \
	docker push ${ECR_URL}/${SERVICE_NAME}:${ENVIRONMENT_TYPE}  && \

	docker tag ${SERVICE_NAME} ${ECR_URL}/${SERVICE_NAME}:${VERSION_NUMBER}  && \
	docker push ${ECR_URL}/${SERVICE_NAME}:${VERSION_NUMBER} || exit 4
fi

popd
