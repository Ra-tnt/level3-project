NAME = raghadq/catalogue
DBNAME = raghadq/catalogue-db
DOCKER_USER = raghadq
DOCKER_PASS = Rand1234@_

TAG= latest

INSTANCE = catalogue

.PHONY: default copy test

default: test

release:
	docker build -t $(NAME) -f ./docker/catalogue/Dockerfile .

test: 
	GROUP=weaveworksdemos COMMIT=test ./scripts/build.sh
	./test/test.sh unit.py
	./test/test.sh container.py --tag $(TAG)

dockertravisbuild: 
	docker build -t $(NAME):$(TAG) -f docker/catalogue/Dockerfile docker/catalogue/
	docker build -t $(DBNAME):$(TAG) -f docker/catalogue-db/Dockerfile docker/catalogue-db/
	docker login -u $(DOCKER_USER) -p $(DOCKER_PASS)
	scripts/push.sh
