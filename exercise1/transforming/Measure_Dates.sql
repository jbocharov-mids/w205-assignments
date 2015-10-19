-- Create the Measure Dates entity for analysis
-- @author jbocharov

CREATE DATABASE IF NOT EXISTS entities;

DROP TABLE IF EXISTS entities.Measure_Dates;
CREATE TABLE entities.Measure_Dates
AS 
SELECT 
  measure_id,
  measure_name,
  measure_start_date,
  measure_end_date
FROM elt.measure_dates;