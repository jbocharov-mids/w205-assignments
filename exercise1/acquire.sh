#! /bin/bash

# @author jbocharov
# This script acquires data from its source and lays it out for ingest into our systems.

URL="https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"

curl "${URL}" > hospitals.zip

unzip -d hospitals_raw hospitals.zip

mkdir -p hospitals

function split_header_and_copy {
  SOURCE=$1
  TARGET=$2

  tail -n +2 "${SOURCE}" > "${TARGET}"
  head -1 "${SOURCE}" > "${TARGET}.header"
}

split_header_and_copy "hospitals_raw/Hospital General Information.csv" hospitals/hospitals.csv

split_header_and_copy "hospitals_raw/Timely and Effective Care - Hospital.csv" hospitals/effective_care.csv

split_header_and_copy "hospitals_raw/Measure Dates.csv" hospitals/measure_dates.csv

split_header_and_copy "hospitals_raw/hvbp_hcahps_05_28_2015.csv" hospitals/surveys_responses.csv




