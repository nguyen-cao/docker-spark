DOCKER_NETWORK = docker-spark_default
current_branch := $(shell git rev-parse --abbrev-ref HEAD)
build:
	docker build -t bde2020/spark-base:$(current_branch) ./base
	docker build -t bde2020/spark-master:$(current_branch) ./master
	docker build -t bde2020/spark-worker:$(current_branch) ./worker
	docker build -t bde2020/spark-submit:$(current_branch) ./submit
	docker build -t bde2020/spark-python-template:$(current_branch) ./template/python

exec:
	docker exec -it spark-master /bin/bash