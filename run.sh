#!/bin/bash

#-----------------------------------
# Spark Parameters
#-----------------------------------
SPARK_DRIVER_MEMORY=2g
SPARK_EXECUTOR_MEMORY=5g
SPARK_EXECUTOR_CORES=2
SPARK_EXECUTOR_INSTANCES=60


# DEPLOY_MODE one of 'cluster' or 'client'
SPARK_DEPLOY_MODE="cluster"

SPARK_MASTER_URL="yarn"

TPCH_HOME=/opt/hadoop/benchmarks/tpch-spark-master
TPCH_JAR="target/scala-2.11/spark-tpc-h-queries_2.11-1.0.jar"
LOGS_DIR=/opt/hadoop/experiment_results/spark/tpch

NUM_OF_TRIALS=5

trial=0
while [ $trial -lt $NUM_OF_TRIALS ]; do
	trial=`expr $trial + 1`
	echo "Executing Trial #$trial of $NUM_OF_TRIALS trial(s)..."

    for i in `seq 01 22`;
    do
	    echo "Executing Query #$i ..."

        (time spark-submit --class "main.scala.TpchQuery" --deploy-mode ${SPARK_DEPLOY_MODE} --master ${SPARK_MASTER_URL} --conf "spark.driver.memory=${SPARK_DRIVER_MEMORY}" --conf "spark.executor.memory=${SPARK_EXECUTOR_MEMORY}"  --conf "spark.executor.cores=${SPARK_EXECUTOR_CORES}" --conf "spark.executor.instances=${SPARK_EXECUTOR_INSTANCES}" --conf "spark.sql.broadcastTimeout=900" "${TPCH_HOME}"/"${TPCH_JAR}" ${i}) 2>&1 | (tee -a "${LOGS_DIR}"/run${trial}/query${i}-run${trial}.log) | grep '^real:'

    done

done # TRIAL
echo "***********************************************"
echo ""


