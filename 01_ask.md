\# 01 — ASK



\## Project Context



This is an independent portfolio project rather than a commissioned analysis.



There is no internal stakeholder providing a confidential business question.



Rather than inventing a business problem before examining the data, the project began with exploratory analysis of a real public AIS dataset.



The evidence discovered during exploration was then used to formulate focused analytical questions.



\---



\## Target Role Context



This project is designed to demonstrate analytical skills relevant to the public:



\*\*Kpler — Junior Market Data Analyst – Chartering\*\*



The role involves working with maritime and other market datasets, investigating inconsistencies and data gaps, validating information, using SQL and Python for analysis, developing repeatable quality checks, and tracking data-quality metrics. 



Kpler's current public posting specifically describes work involving vessel characteristics, vessel positions, AIS data, data gaps, inconsistencies, validation checks, and systematic data-quality improvements.



\---



\## Initial Objective



> Assess the completeness, temporal continuity, and basic validity of publicly available AIS vessel data and identify patterns that warrant further investigation.



\---



\# How the Questions Were Developed



The analytical questions were not predetermined.



The workflow was:



1\. Obtain a real public AIS dataset.

2\. Profile its structure and coverage.

3\. Measure missingness.

4\. Compare missingness across vessel categories.

5\. Examine temporal observation intervals.

6\. Test basic field validity.

7\. Use the observed patterns to define focused analytical questions.



This approach avoids inventing a problem that the data does not demonstrate.



\---



\# Analytical Questions



\## Question 1 — Metadata Completeness



> How does completeness of vessel metadata vary across vessel categories?



\### Fields



\- IMO

\- Draft

\- Cargo

\- Vessel Type

\- Vessel Name

\- Length

\- Width



\---



\## Question 2 — Temporal Continuity



> How consistent are vessel observation intervals, and where do unusually long gaps occur?



\### Fields



\- MMSI

\- BaseDateTime



\---



\## Question 3 — Data Validity



> Are there records containing potentially invalid or anomalous values in key movement and vessel-characteristic fields?



\### Fields



\- LAT

\- LON

\- SOG

\- COG

\- Length

\- Width



\---



\# Stakeholder Assumption



No proprietary Kpler stakeholder requirements are assumed.



Kpler is used as the target-role context for demonstrating relevant analytical capabilities.



This is an independent project and does not claim to represent Kpler's internal data, systems, processes, or requirements.



\---



\# Success Criteria



The project should demonstrate the ability to:



\- work with a large real-world dataset

\- use SQL to investigate data quality

\- identify patterns from raw data

\- formulate analytical questions from evidence

\- create reproducible validation checks

\- distinguish anomalies from confirmed errors

\- communicate findings clearly

\- translate findings into practical data-quality recommendations

