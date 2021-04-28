run:
	docker run --name spark-master -h spark-master -e ENABLE_INIT_DAEMON=false -p 8080:8080 -d bde2020/spark-master:3.1.1-hadoop3.2
	docker run --name spark-worker-1 --link spark-master:spark-master -e ENABLE_INIT_DAEMON=false -d bde2020/spark-worker:3.1.1-hadoop3.2

stop:
	docker stop spark-worker-1 spark-master
	docker rm spark-worker-1 spark-master