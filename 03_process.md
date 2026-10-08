\# 03 — PROCESS



\## Purpose



The processing phase converts the exploratory findings into a reproducible and documented data-quality workflow.



The raw NOAA AIS CSV is preserved and is not modified directly.



All transformations and validation rules will be implemented through documented SQL.



\---



\# Processing Principles



\## 1. Preserve the raw source



The original CSV remains unchanged.



No values will be overwritten in the raw dataset.



\---



\## 2. Measure before modifying



The exploratory analysis is used to identify:



\- missing values

\- temporal gaps

\- potentially anomalous values

\- differences between vessel categories



A value will not be changed simply because it is unusual.



\---



\## 3. Distinguish different types of data-quality issues



The analysis distinguishes between:



\### Missing



A field contains `NULL`.



\### Zero / unknown candidate



A numeric field contains `0`.



A zero value will not automatically be treated as missing until the source documentation confirms the meaning of the value.



\### Flagged



A value meets a validation rule and requires investigation.



A flagged value is not automatically an error.



\### Invalid



A value violates a clearly established structural or domain constraint.



Only values supported by the source documentation or a defensible analytical rule will be classified as invalid.



\---



\# Initial Processing Checks



The following checks have already been implemented in SQL.



\## Metadata completeness



Fields examined:



\- IMO

\- Draft

\- Cargo

\- VesselName

\- VesselType

\- Length

\- Width



Missingness is measured at the vessel level using MMSI.



This prevents the same vessel's repeated AIS observations from dominating the completeness analysis.



\---



\## Temporal continuity



For each MMSI:



1\. Sort observations chronologically.

2\. Identify the previous observation using `LAG()`.

3\. Calculate the time difference between consecutive observations.

4\. Summarize the distribution of gaps.



Large gaps are treated as candidates for investigation rather than automatically classified as errors.



\---



\## Field validity



Initial structural checks examine:



\- Latitude

\- Longitude

\- Speed Over Ground (SOG)

\- Course Over Ground (COG)

\- Vessel Length

\- Vessel Width



The current analysis identifies records requiring further interpretation.



\---



\# Current Findings Requiring Interpretation



\## IMO



A large proportion of vessels have no IMO value in the working dataset.



This will be reported as metadata incompleteness.



The project will not attempt to invent or impute IMO numbers.



\---



\## Draft and Cargo



A substantial proportion of vessels have missing Draft and Cargo values.



The project will investigate the pattern of missingness rather than automatically filling these fields.



\---



\## Vessel Length and Width



The dataset contains zero values for Length and Width.



Current counts:



\- Zero Length: 66,619 observations

\- Zero Width: 93,538 observations



No negative Length or Width values were identified.



Before deciding whether zero represents missing, unknown, or another source-specific condition, the field definitions will be checked against the NOAA documentation.



\---



\## Speed Over Ground



7,275 observations were flagged by the initial SOG range check.



These records will be treated as flagged observations rather than automatically classified as erroneous.



Further interpretation will depend on the documented AIS field definition and valid encoded range.



\---



\## Latitude / Longitude



No observations violated the basic geographic ranges used in the validation check:



\- Latitude: -90 to 90

\- Longitude: -180 to 180



\---



\## Course Over Ground



No observations violated the basic 0–360 degree range used in the validation check.



\---



\# Processing Output



The final processing stage should produce analysis-ready datasets or query outputs for:



1\. Metadata completeness

2\. Temporal continuity

3\. Field validity



These outputs will be used during the ANALYZE phase.



\---



\# Reproducibility



The processing workflow is implemented using SQL scripts stored in:



`sql/`



Current scripts:



\- `01\_profile.sql`

\- `02\_metadata\_quality.sql`

\- `03\_temporal\_gaps.sql`

\- `04\_validity\_checks.sql`



The raw CSV remains outside the GitHub repository because of its size.



The repository will document the original source, geographic selection, date range, transformations, and reproducibility steps.

