-- Create the Hospitals entity for analysis
-- @author jbocharov

CREATE DATABASE IF NOT EXISTS entities;

DROP TABLE IF EXISTS entities.Hospitals;
CREATE TABLE entities.Hospitals
AS 
SELECT 
  provider_id,
  hospital_name,
  state
FROM elt.hospitals;