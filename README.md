# Spark TPCH

Script to run TPC-H benchmark for Spark system.

## Setup actions
Set `OUTPUT_DIR` and `INPUT_DIR` inside TpchQuery.scala. Current values are set to HDFS directories. Ensure the HDFS directories are created before running the benchmark

Install `sbt` package

Now run `sbt package` to compile the project

## Usage
`./run.sh`

## Further Guide
See Spark_TPCH_README.md for more details
