IMAGE_NAME=andrey0001/pritunl

all:
		docker build -t $(IMAGE_NAME) .

clean:
		docker rmi $(IMAGE_NAME) || true

