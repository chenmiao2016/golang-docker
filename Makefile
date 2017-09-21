IMAGE_NAME = golang
IMAGE_TAG = 1.8.3

HARBOR_USERNAME = admin
HARBOR_PASSWORD = Harbor12345
#REG_URL = reg.dhdc.com
REG_URL = harbor.dahuatech.com
PROJECT_NAME = chenmiao

build:
	docker build -t $(IMAGE_NAME):$(IMAGE_TAG) .
	docker images|grep none|awk '{print $$3}'|xargs -r docker rmi
push:
	docker tag $(IMAGE_NAME):$(IMAGE_TAG) $(REG_URL)/$(PROJECT_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)
	docker login -u $(HARBOR_USERNAME) -p $(HARBOR_PASSWORD) $(REG_URL)
	docker push $(REG_URL)/$(PROJECT_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)
	docker rmi $(REG_URL)/$(PROJECT_NAME)/$(IMAGE_NAME):$(IMAGE_TAG)
clean:
	docker rmi $(IMAGE_NAME):$(IMAGE_TAG)
up:
	docker-compose up -d
