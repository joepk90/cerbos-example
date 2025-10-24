CERBOS_IMAGE_NAME=cerbos-example
VALIDATION_IMAGE_NAME=cerbos-example
TAG=latest

IMAGE=${IMAGE_NAME}:${TAG}

docker-build:
	docker build -t ${CERBOS_IMAGE_NAME} .

docker-run:
	docker run -it -p 3592:3592 ${CERBOS_IMAGE_NAME}

docker-validate-build:
	docker build -t ${VALIDATION_IMAGE_NAME} .

docker-validate-run:
	docker run -it -p 3592:3592 ${VALIDATION_IMAGE_NAME}