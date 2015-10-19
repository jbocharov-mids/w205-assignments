-- Compute correlation between zscores and patient scores
-- @author jbocharov

-- Similar to best_hospitals, we compute the mean z-score for each hospital,
-- and then inner join it to the survey results, and compute an
-- overall correlation.

SELECT 
  corr(
    Procedures_With_ZScores.mean_zscore,
    Survey_Results.score
  ) AS hospital_survey_correlation
FROM 
  (SELECT 
      Procedures.provider_id AS provider_id,
      Procedures.hospital_name AS hospital_name,
      AVG(( Procedures.score - Measure_Norms.score_mean ) 
        / Measure_Norms.score_stddev) AS mean_zscore
    FROM entities.Procedures
      INNER JOIN entities.Measure_Norms
      ON Procedures.measure_id = Measure_Norms.measure_id
    GROUP BY provider_id, hospital_name
  ) AS Procedures_With_ZScores
  INNER JOIN entities.Survey_Results
  ON Procedures_With_ZScores.provider_id = Survey_Results.provider_id;