-- Create the Measure_Norms entity for analysis
-- @author jbocharov

CREATE DATABASE IF NOT EXISTS entities;

DROP TABLE IF EXISTS entities.Measure_Norms;

-- As discovered in Data_Exploration.sql, need to:
--   a) Compute Scores 
--   b) Keep only 09/30/2014 end date measures (over 10x rest of data)
--   c) Discard Not Available scores

CREATE TABLE entities.Measure_Norms
AS
SELECT 
  measure_id,
  AVG(score) AS score_mean,
  STDDEV_POP(score) AS score_stddev,
  COUNT(score) AS observations,
  measure_name
FROM elt.effective_care
WHERE 
  measure_end_date = '09/30/2014'
  AND score <> 'Not Available'
GROUP BY
  measure_id, measure_name;