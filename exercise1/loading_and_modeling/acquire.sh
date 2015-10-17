#! /bin/bash

# @author jbocharov
# This script acquires data from its source and lays it out for ingest into our systems.
set -x # echo on

URL="https://data.medicare.gov/views/bg9k-emty/files/Nqcy71p9Ss2RSBWDmP77H1DQXcyacr2khotGbDHHW_s?content_type=application%2Fzip%3B%20charset%3Dbinary&filename=Hospital_Revised_Flatfiles.zip"

HOSPITALS_RAW="../hospitals_raw"
HOSPITALS="../hospitals"
ZIPROOT=".."

curl "${URL}" > "${ZIPROOT}/hospitals.zip"

unzip -o -d "${HOSPITALS_RAW}" "${ZIPROOT}/hospitals.zip"

mkdir -p "${HOSPITALS}"

function split_header_and_copy {
  SOURCE=$1
  TARGET=$2

  tail -n +2 "${HOSPITALS_RAW}/${SOURCE}" > "${HOSPITALS}/${TARGET}"
  head -1 "${HOSPITALS_RAW}/${SOURCE}" > "${HOSPITALS}/${TARGET}.header"
}

split_header_and_copy "Hospital General Information.csv" hospitals.csv

split_header_and_copy "Timely and Effective Care - Hospital.csv" effective_care.csv

split_header_and_copy "Measure Dates.csv" measure_dates.csv

split_header_and_copy "hvbp_hcahps_05_28_2015.csv" surveys_responses.csv

split_header_and_copy "Readmissions and Deaths - Hospital.csv" readmissions.csv