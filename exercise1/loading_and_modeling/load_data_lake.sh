#! /bin/bash

HOSPITAL_DATA="../hospitals"

HDFS_HOSPITAL_COMPARE=/user/w205/hospital_compare

hdfs dfs -mkdir -p "${HDFS_HOSPITAL_COMPARE}"

function put {
  HDFS_DIRECTORY=$1
  LOCAL_PATH=$2
  hdfs dfs -mkdir -p \
    "${HDFS_HOSPITAL_COMPARE}/${HDFS_DIRECTORY}"
  hdfs dfs -put -f \
    "${HOSPITAL_DATA}/${LOCAL_PATH}" \
    "${HDFS_HOSPITAL_COMPARE}/${HDFS_DIRECTORY}" 
}

put hospitals hospitals.csv

put effective_care effective_care.csv

put measure_dates measure_dates.csv

put surveys_responses surveys_responses.csv

