#!/bin/bash

parent_directory=$(dirname $0)

  CONTAINER_NAME="${SERVICE_NAME}-${BUILD_NUMBER}-test"
  echo "Container name: ${CONTAINER_NAME}"
  echo "RUN: docker run -d -e NODE_ENV=development -e ENVIRONMENT_TYPE=$ENVIRONMENT_TYPE -e SERVICE_NAME=$SERVICE_NAME --name $CONTAINER_NAME ${SERVICE_NAME}-${BUILD_NUMBER}"
	docker run -d -e NODE_ENV=development \
                -e ENVIRONMENT_TYPE=$ENVIRONMENT_TYPE \
                -e SERVICE_NAME=$SERVICE_NAME \
                --name $CONTAINER_NAME ${SERVICE_NAME}-${BUILD_NUMBER}
	docker logs $CONTAINER_NAME
	docker_state=$(docker inspect -f {{.State.Running}} $CONTAINER_NAME)
	echo "Docker state: ${docker_state}"
  cleandocker()
  echo "xui"
	#while [ $(docker inspect -f {{.State.Running}} $CONTAINER_NAME) == "true" ] ; do
	#	docker exec -t $CONTAINER_NAME npm run test
	#	unitest_status=$?
	#	echo "UNITEST STATUS : $unitest_status"
	#	break
	#done

	#if [ "$unitest_status" -ne 0 ] ; then
	#	echo "Unitest failed : $unitest_status , $?"
	#	cleandocker
	#	exit 3
	#else
	#	cleandocker
	#fi

#fi

function cleandocker () {
	docker kill $CONTAINER_NAME
	docker rm $CONTAINER_NAME
}
