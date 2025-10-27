
CERBOS_SERVICE_IMAGE_NAME=cerbos-example
TAG=latest
SERVICE_IMAGE=${CERBOS_SERVICE_IMAGE_NAME}:${TAG}

docker-build:
	docker build -t ${SERVICE_IMAGE} .

docker-run:
	docker run -it -p 3592:3592 ${SERVICE_IMAGE}

validate:
	docker run -i -t -v $$(pwd)/config:/etc/cerbos -v $$(pwd)/policies:/policies ghcr.io/cerbos/cerbos:0.46.0 compile --skip-tests /policies


# alternative approach for validation using docker image

CERBOS_VALIDATION_IMAGE_NAME=cerbos-example-validation
VALIDATION_IMAGE=${CERBOS_VALIDATION_IMAGE_NAME}:${TAG}
docker-validate-build:
	docker build -t ${CERBOS_VALIDATION_IMAGE_NAME} -f Dockerfile.validate .

docker-validate-run:
	docker run -it -v $$(pwd)/config:/etc/cerbos -v $$(pwd)/policies:/policies ${CERBOS_VALIDATION_IMAGE_NAME}