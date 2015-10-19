-- Generate the most variable procedures between hospitals
-- @author jbocharov


SELECT 
  measure_id,
  score_stddev,
  measure_name
FROM 
  entities.Measure_Norms
ORDER BY score_stddev DESC
LIMIT 10;