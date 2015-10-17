#! /bin/bash
set -x # echo on

HOSPITAL_DATA="../hospitals"

HDFS_HOSPITALS_COMPARE=/user/w205/hospitals_compare

hdfs dfs -mkdir -p "${HDFS_HOSPITALS_COMPARE}"

function put {
  HDFS_DIRECTORY=$1
  LOCAL_PATH=$2
  hdfs dfs -mkdir -p \
    "${HDFS_HOSPITALS_COMPARE}/${HDFS_DIRECTORY}"
  hdfs dfs -put -f \
    "${HOSPITAL_DATA}/${LOCAL_PATH}" \
    "${HDFS_HOSPITALS_COMPARE}/${HDFS_DIRECTORY}/${LOCAL_PATH}" 
}

put hospitals hospitals.csv

put effective_care effective_care.csv

put measure_dates measure_dates.csv

put surveys_responses surveys_responses.csv

