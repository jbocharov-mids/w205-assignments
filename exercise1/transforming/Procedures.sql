-- Create the Procedures entity for analysis
-- @author jbocharov

CREATE DATABASE IF NOT EXISTS entities;

DROP TABLE IF EXISTS entities.Procedures;

-- As discovered in Data_Exploration.sql, need to:
--   a) cast score to INT
--   b) Keep only 09/30/2014 end date measures (over 10x rest of data)
--   c) Discard Not Available scores

CREATE TABLE entities.Procedures
AS
SELECT 
  provider_id,
  hospital_name,
  condition,
  measure_id, 
  measure_name,
  measure_end_date,
  CAST(score AS INT),
  state
FROM elt.effective_care 
WHERE 
  measure_end_date = '09/30/2014'
  AND score <> 'Not Available';