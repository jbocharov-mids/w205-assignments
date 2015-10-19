-- Create the Survey Results entity for analysis
-- @author jbocharov

CREATE DATABASE IF NOT EXISTS entities;

DROP TABLE IF EXISTS entities.Survey_Results;

-- As discovered in Data_Exploration.sql, need to:
--   a) Remove Out of 10 from the scores
--   b) cast result to INT
--   c) Remove Not Available rows
-- Also need to rename provider_number to provider_id for consistency

CREATE TABLE entities.Survey_Results
AS

SELECT 
  provider_number AS provider_id,
  hospital_name,
  state,
  CAST(regexp_replace(
    overall_rating_of_hospital_dimension_score,
    ' out of 10.*$',
    ''
  ) AS INT) AS score
FROM elt.surveys_responses
WHERE overall_rating_of_hospital_dimension_score <> 'Not Available';