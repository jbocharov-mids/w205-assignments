-- Data exploration to determine the right SQL
-- @author jbocharov

--  Question 1: What start and end dates shoud we use?

SELECT 
  measure_start_date, 
  measure_end_date,
  COUNT(provider_id) AS count
FROM elt.effective_care
GROUP BY measure_start_date, measure_end_date;

-- measure_start_date  measure_end_date  count
-- 01/01/2013          12/31/2013        8790
-- 01/01/2014          09/30/2014        4785
-- 10/01/2013          03/31/2014        8435
-- 10/01/2013          09/30/2014        195811


-- Answer 1: Select 09/30/2014 as the measure end date (most data)

-- Question 2: How should we encode the score for procedures?

SELECT 
  measure_id, 
  MIN(CAST(score AS INT)) AS min_score, 
  MAX(CAST(score AS INT)) AS max_score, 
  COUNT(provider_id) AS count, 
  measure_name 
FROM elt.effective_care 
WHERE 
  measure_end_date = '09/30/2014'
  AND score <> 'Not Available'
GROUP BY measure_id, measure_name;

-- measure_id  min_score max_score count measure_name
-- AMI_10  25  100 2188  Statin at Discharge
-- AMI_2 36  100 2207  Aspirin prescribed at discharge
-- AMI_7a  27  73  3 Fibrinolytic Therapy Received Within 30 Minutes Of Hospital Arrival
-- AMI_8a  33  100 1528  Primary PCI Received Within 90 Minutes of Hospital Arrival
-- CAC_1 99  100 97  Relievers for Inpatient Asthma
-- CAC_2 91  100 97  Systemic Corticosteroids for Inpatient Asthma
-- CAC_3 34  100 96  Home Management Plan of Care Document
-- ED_1b 53  100 27  ED1
-- ED_2b 0 100 2202  ED2
-- HF_1  0 100 2934  Discharge instructions
-- HF_2  0 100 3781  Evaluation of LVS Function
-- HF_3  18  100 2692  ACEI or ARB for LVSD
-- OP_1  15  64  68  Median Time to Fibrinolysis
-- OP_18b  44  100 431 OP 18
-- OP_2  27  100 68  Fibrinolytic Therapy Received Within 30 Minutes of ED Arrival
-- OP_20 0 100 3338  Door to diagnostic eval
-- OP_21 12  100 3118  Median time to pain med
-- OP_23 0 100 959 Head CT results
-- OP_3b 21  100 378 Median Time to Transfer to Another Facility for Acute Coronary Intervention
-- OP_4  57  100 2087  Aspirin at Arrival
-- OP_5  0 71  2098  Median Time to ECG
-- OP_6  25  100 2909  Prophylactic Antibiotic Initiated Within One Hour Prior to Surgical Incision
-- OP_7  38  100 2914  Prophylactic Antibiotic Selection for Surgical Patients
-- PC_01 0 100 2520  Percent of newborns whose deliveries were scheduled early (1-3 weeks early), when a scheduled delivery was not medically necessary
-- PN_6  20  100 3973  Initial antibiotic selection for CAP in immunocompetent patient
-- SCIP_CARD_2 7 100 3149  Surgery Patients on a Beta Blocker Prior to Arrival Who Received a Beta Blocker During the Perioperative Period
-- SCIP_INF_1  0 100 3476  Prophylactic antibiotic received within 1 hour prior to surgical incision
-- SCIP_INF_10 33  100 3259  Surgery Patients with Perioperative Temperature Management
-- SCIP_INF_2  9 100 3467  Prophylactic Antibiotic Selection for Surgical Patients
-- SCIP_INF_3  9 100 3457  Prophylactic antibiotics discontinued within 24 hours after surgery end time
-- SCIP_INF_9  55  100 3329  Postoperative Urinary Catheter Removal
-- SCIP_VTE_2  0 100 3519  Surgery Patients Who Received Appropriate Venous Thromboembolism Prophylaxis Within 24 Hours Prior to Surgery to 24 Hours After Surgery
-- STK_1 0 100 2710  Venous Thromboembolism (VTE) Prophylaxis
-- STK_10  4 100 2702  Assessed for Rehabilitation
-- STK_2 36  100 2673  Discharged on Antithrombotic Therapy
-- STK_3 46  100 1499  Anticoagulation Therapy for Atrial Fibrillation/Flutter
-- STK_4 0 100 874 Thrombolytic Therapy
-- STK_5 0 100 2675  Antithrombotic Therapy by End of Hospital Day 2
-- STK_6 18  100 2582  Discharged on Statin Medication
-- STK_8 0 100 2372  Stroke Education
-- VTE_1 0 100 3534  Venous thromboembolism prophylaxis
-- VTE_2 0 100 2955  ICU venous thromboembolism prophylaxis
-- VTE_3 36  100 2666  Anticoagulation overlap therapy
-- VTE_4 0 100 2045  Unfractionated heparin with dosages/platelet count monitoring
-- VTE_5 0 100 2468  Warfarin therapy discharge instructions
-- VTE_6 0 71  1388  Incidence of potentially preventable VTE


-- Answer 2: We encode scores as integers, removing
-- Not Available values
-- Since scores have distinct ranges we compute a Measure_Norms entity
--   so that scores for various procedures can be compared by Z-score


-- Question 3: How should we encode the score for surveys?

SELECT 
  overall_rating_of_hospital_dimension_score, 
  COUNT(provider_number) AS count
FROM elt.surveys_responses
GROUP BY overall_rating_of_hospital_dimension_score;

-- overall_rating_of_hospital_dimension_score  count
-- 0 out of 10                                 784
-- 1 out of 10                                 407
-- 10 out of 10                                150
-- 2 out of 10                                 376
-- 3 out of 10                                 338
-- 4 out of 10                                 302
-- 5 out of 10                                 234
-- 6 out of 10                                 200
-- 7 out of 10                                 114
-- 8 out of 10                                 81
-- 9 out of 10                                 56
-- Not Available                               32

SELECT 
  CAST(regexp_replace(
    overall_rating_of_hospital_dimension_score,
    ' out of 10.*$',
    ''
  ) AS INT) AS score, 
  COUNT(provider_number) AS count
FROM elt.surveys_responses
WHERE overall_rating_of_hospital_dimension_score <> 'Not Available'
GROUP BY overall_rating_of_hospital_dimension_score
ORDER BY score ASC;

-- score count
-- 0     784
-- 1     407
-- 2     376
-- 3     338
-- 4     302
-- 5     234
-- 6     200
-- 7     114
-- 8     81
-- 9     56
-- 10    150

-- Answer 3: we encode score as an integer 0-10, discarding the "out of 10",
-- and filtering out the Not Available entries
