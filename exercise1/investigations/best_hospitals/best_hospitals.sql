-- Generate the top 10 best hospitals from the data
-- @author jbocharov

-- As discovered in Data_Exploration.sql, because the scores for each
-- procedure have very different ranges, all the scores are normalized
-- to Z-Scores using the pre-computed mean and standard deviation
-- for the score for each procedure type

SELECT 
  provider_id,
  hospital_name,
  AVG(zscore) AS mean_zscore,
  COUNT(DISTINCT measure_name) AS distinct_procedures
FROM 
  (SELECT 
      Procedures.provider_id AS provider_id,
      Procedures.hospital_name AS hospital_name,
      Procedures.measure_id AS measure_id,
      Procedures.measure_name AS measure_name,
      ( Procedures.score - Measure_Norms.score_mean ) 
        / Measure_Norms.score_stddev AS zscore
    FROM entities.Procedures
    INNER JOIN entities.Measure_Norms
    ON Procedures.measure_id = Measure_Norms.measure_id
  ) AS Procedures_With_ZScores
GROUP BY provider_id, hospital_name
ORDER BY mean_zscore DESC
LIMIT 10;