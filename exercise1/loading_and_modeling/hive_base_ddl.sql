-- Import data into Hive tables
-- @author jbocharov

-- From inspection, all the rows are quoted, leading to initial 
-- representation as strings (can interpret after the fact in queries)

DROP TABLE IF EXISTS hospitals;
CREATE EXTERNAL TABLE hospitals (
  Provider_ID VARCHAR(255),
  Hospital_Name VARCHAR(255),
  Address VARCHAR(255),
  City VARCHAR(255),
  State VARCHAR(255),
  ZIP_Code VARCHAR(255),
  County_Name VARCHAR(255),
  Phone_Number VARCHAR(255),
  Hospital_Type VARCHAR(255),
  Hospital_Ownership VARCHAR(255),
  Emergency_Services VARCHAR(255)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/w205/hospitals_compare/hospitals';

DROP TABLE IF EXISTS effective_care;
CREATE EXTERNAL TABLE effective_care (
  Provider_ID VARCHAR(255),
  Hospital_Name VARCHAR(255),
  Address VARCHAR(255),
  City VARCHAR(255),
  State VARCHAR(255),
  ZIP_Code VARCHAR(255),
  County_Name VARCHAR(255),
  Phone_Number VARCHAR(255),
  Condition VARCHAR(255),
  Measure_ID VARCHAR(255),
  Measure_Name VARCHAR(255),
  Score VARCHAR(255),
  Sample VARCHAR(255),
  Footnote VARCHAR(255),
  Measure_Start_Date VARCHAR(255),
  Measure_End_Date VARCHAR(255)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/w205/hospitals_compare/effective_care';

DROP TABLE IF EXISTS measure_dates;
CREATE EXTERNAL TABLE measure_dates (
  Measure_Name VARCHAR(255),
  Measure_ID VARCHAR(255),
  Measure_Start_Quarter VARCHAR(255),
  Measure_Start_Date VARCHAR(255),
  Measure_End_Quarter VARCHAR(255),
  Measure_End_Date VARCHAR(255)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/w205/hospitals_compare/measure_dates';

DROP TABLE IF EXISTS surveys_responses;
CREATE EXTERNAL TABLE surveys_responses (
  Provider_Number VARCHAR(255),
  Hospital_Name VARCHAR(255),
  Address VARCHAR(255),
  City VARCHAR(255),
  State VARCHAR(255),
  ZIP_Code VARCHAR(255),
  County_Name VARCHAR(255),
  Communication_with_Nurses_Achievement_Points VARCHAR(255),
  Communication_with_Nurses_Improvement_Points VARCHAR(255),
  Communication_with_Nurses_Dimension_Score VARCHAR(255),
  Communication_with_Doctors_Achievement_Points VARCHAR(255),
  Communication_with_Doctors_Improvement_Points VARCHAR(255),
  Communication_with_Doctors_Dimension_Score VARCHAR(255),
  Responsiveness_of_Hospital_Staff_Achievement_Points VARCHAR(255),
  Responsiveness_of_Hospital_Staff_Improvement_Points VARCHAR(255),
  Responsiveness_of_Hospital_Staff_Dimension_Score VARCHAR(255),
  Pain_Management_Achievement_Points VARCHAR(255),
  Pain_Management_Improvement_Points VARCHAR(255),
  Pain_Management_Dimension_Score VARCHAR(255),
  Communication_about_Medicines_Achievement_Points VARCHAR(255),
  Communication_about_Medicines_Improvement_Points VARCHAR(255),
  Communication_about_Medicines_Dimension_Score VARCHAR(255),
  Cleanliness_and_Quietness_of_Hospital_Environment_Achievement_Points VARCHAR(255),
  Cleanliness_and_Quietness_of_Hospital_Environment_Improvement_Points VARCHAR(255),
  Cleanliness_and_Quietness_of_Hospital_Environment_Dimension_Score VARCHAR(255),
  Discharge_Information_Achievement_Points VARCHAR(255),
  Discharge_Information_Improvement_Points VARCHAR(255),
  Discharge_Information_Dimension_Score VARCHAR(255),
  Overall_Rating_of_Hospital_Achievement_Points VARCHAR(255),
  Overall_Rating_of_Hospital_Improvement_Points VARCHAR(255),
  Overall_Rating_of_Hospital_Dimension_Score VARCHAR(255),
  HCAHPS_Base_Score VARCHAR(255),
  HCAHPS_Consistency_Score VARCHAR(255)
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE
LOCATION '/user/w205/hospitals_compare/surveys_responses';

