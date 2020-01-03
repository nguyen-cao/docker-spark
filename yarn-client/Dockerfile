FROM bde2020/spark-base:2.4.4-hadoop2.7

ENV SPARK_MASTER_NAME spark-master
ENV SPARK_MASTER_PORT 7077

RUN mkdir -p /opt/hadoop/conf/

COPY config/core-site.xml config/hdfs-site.xml config/yarn-site.xml config/mapred-site.xml config/hdfs-site.xml /opt/hadoop/conf/
COPY config/spark-defaults.conf /spark/conf/

ENV YARN_CONF_DIR=/opt/hadoop/conf
ENV PYSPARK_PYTHON=python3.7
ENV PYTHONHASHSEED=1234
ENV SPARK_YARN_USER_ENV="PYSPARK_PYTHON=python3.7,PYTHONHASHSEED=1234"

COPY submit.sh /

CMD ["/bin/bash", "/submit.sh"]
