SPARK_DOCKER_NETWORK = docker-spark_default
current_branch := $(shell git rev-parse --abbrev-ref HEAD)

HADOOP_DOCKER_NETWORK = docker-hadoop_default
ENV_FILE = hadoop.env
hadoop_branch = 3.2.1

build:
	docker build -t bde2020/spark-base:$(current_branch) ./base
	docker build -t bde2020/spark-master:$(current_branch) ./master
	docker build -t bde2020/spark-worker:$(current_branch) ./worker
	docker build -t bde2020/spark-submit:$(current_branch) ./submit
	docker build -t bde2020/spark-yarn-client:$(current_branch) ./yarn-client
	docker build -t bde2020/spark-python-template:$(current_branch) ./template/python

setup_spark_hadoop:
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(hadoop_branch) hdfs dfs -mkdir /user/spark
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(hadoop_branch) hdfs dfs -mkdir /user/spark/libs
	docker run --network ${DOCKER_NETWORK} --env-file ${ENV_FILE} bde2020/hadoop-base:$(hadoop_branch) hdfs dfs -copyFromLocal /spark/jars /user/spark/libs