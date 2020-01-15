SPARK_DOCKER_NETWORK = docker-spark_default
current_branch := $(shell git rev-parse --abbrev-ref HEAD)

IMAGE_TAG = 2.4.4-hadoop2.7
HADOOP_DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
HADOOP_IMAGE_TAG = 3.2.1

build:
	docker build -t bde2020/spark-base:${IMAGE_TAG} ./base
	docker build -t bde2020/spark-master:${IMAGE_TAG} ./master
	docker build -t bde2020/spark-worker:${IMAGE_TAG} ./worker
	docker build -t bde2020/spark-submit:${IMAGE_TAG} ./submit
	docker build -t bde2020/spark-yarn-client:${IMAGE_TAG} ./yarn-client
	docker build -t bde2020/spark-python-template:${IMAGE_TAG} ./template/python

setup_spark_hadoop:
	docker run --network ${HADOOP_DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${HADOOP_IMAGE_TAG} hdfs dfs -mkdir -p /user
	docker run --network ${HADOOP_DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${HADOOP_IMAGE_TAG} hdfs dfs -mkdir -p /user/spark
	docker run --network ${HADOOP_DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:${HADOOP_IMAGE_TAG} hdfs dfs -mkdir -p /user/spark/libs
	docker run --network ${HADOOP_DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-resourcemanager:${HADOOP_IMAGE_TAG} hdfs dfs -copyFromLocal /spark/jars /user/spark/libs

start_local_cluster_1:
	docker-compose -f docker-compose-local.yml up