CERBOS_IMAGE_NAME=cerbos-example
TAG=latest

IMAGE=${IMAGE_NAME}:${TAG}

docker-build:
	docker build -t ${CERBOS_IMAGE_NAME} .

docker-run:
	docker run -it -p 3592:3592 ${CERBOS_IMAGE_NAME}