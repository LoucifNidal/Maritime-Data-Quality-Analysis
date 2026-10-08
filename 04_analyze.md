\# 04 — ANALYZE



\## Purpose



The analysis phase turns the processed data into evidence-based findings.



The objective is not to identify every possible issue in the dataset.



Instead, the analysis focuses on three questions that emerged from the exploratory investigation:



1\. How does completeness of vessel metadata vary across vessel categories?

2\. How consistent are vessel observation intervals, and where do unusually long gaps occur?

3\. Are there records containing potentially invalid or anomalous values in key movement and vessel-characteristic fields?



The findings below are based on the selected NOAA AIS dataset covering the San Pedro Bay area from January 1 to January 14, 2025.



\---



\# Question 1 — Metadata Completeness



\## Analytical Question



How does completeness of vessel metadata vary across vessel categories?



\## Method



The analysis evaluates metadata completeness at the vessel level using MMSI.



The following fields were examined:



\- IMO

\- Draft

\- Cargo

\- VesselName

\- VesselType

\- Length

\- Width



A vessel is considered to have a field available when at least one observation for that vessel contains a non-null value.



This approach prevents vessels with many repeated AIS observations from dominating the completeness analysis.



\## Findings



Metadata completeness varies substantially between vessel categories.



The largest vessel groups in the working dataset include:



\- Pleasure Craft

\- Sailing

\- Cargo Ship

\- Passenger Ship

\- Fishing

\- Tanker

\- Other / Unclassified

\- Towing

\- Tug



The pattern is not uniform across categories.



For example:



\- Cargo Ship and Tanker vessels show complete availability of IMO, Draft, and Cargo in this working dataset.

\- Pleasure Craft and Sailing vessels show very high levels of missing IMO, Draft, and Cargo information.

\- Passenger vessels show a more mixed pattern, with substantially better Draft and Cargo availability than IMO availability.

\- Several smaller vessel categories also show high levels of missing metadata.



\## Interpretation



The results indicate that metadata completeness is strongly associated with vessel category.



This means that a single overall completeness percentage would hide important differences between groups.



The findings should therefore be interpreted as a \*\*pattern of metadata availability\*\*, rather than automatically as evidence that one vessel category contains "bad data."



Different vessel categories may have different reporting or identification characteristics.



\## Analytical Takeaway



Metadata quality should be evaluated by vessel category rather than only at the dataset-wide level.



This type of segmentation can help identify where additional validation or enrichment may provide the greatest value.



\---



\# Question 2 — Temporal Continuity



\## Analytical Question



How consistent are vessel observation intervals, and where do unusually long gaps occur?



\## Method



For each MMSI:



1\. Observations were ordered chronologically.

2\. The previous timestamp was identified using `LAG()`.

3\. The difference between consecutive observations was calculated in minutes.

4\. The resulting distribution was summarized using percentile statistics.



\## Findings



The dataset contains:



\- 2,209,706 consecutive observation intervals

\- Minimum gap: 0 minutes

\- Median gap: 3 minutes

\- 90th percentile: 6 minutes

\- 95th percentile: approximately 9 minutes

\- 99th percentile: approximately 18 minutes

\- Maximum gap: approximately 19,307 minutes



The maximum observed gap is approximately 13.4 days.



\## Interpretation



Most consecutive observations occur within a relatively short interval.



The median interval is 3 minutes, while 99% of intervals are approximately 18 minutes or less.



However, a small number of much larger gaps exist.



These large gaps should not automatically be classified as data errors.



Possible explanations could include vessels leaving the selected geographic area, vessels returning later, changes in observation availability, or other characteristics of the source and geographic selection.



The current analysis identifies these gaps as candidates for further investigation rather than confirmed data-quality failures.



\## Analytical Takeaway



Temporal continuity is generally concentrated around short observation intervals, but the distribution has a long tail of unusually large gaps.



A data-quality workflow could therefore use gap thresholds to flag observations for investigation without automatically deleting or correcting them.



\---



\# Question 3 — Field Validity



\## Analytical Question



Are there records containing potentially invalid or anomalous values in key movement and vessel-characteristic fields?



\## Method



Structural validation checks were applied to:



\- Latitude

\- Longitude

\- Speed Over Ground (SOG)

\- Course Over Ground (COG)

\- Length

\- Width



The checks identify values outside expected structural ranges or values requiring further interpretation.



\## Findings



The validation checks produced the following results:



| Field | Result |

|---|---:|

| Total observations | 2,210,745 |

| Invalid Latitude | 0 |

| Invalid Longitude | 0 |

| SOG above initial threshold | 7,275 |

| Invalid COG | 0 |

| Zero Length | 66,619 |

| Negative Length | 0 |

| Zero Width | 93,538 |

| Negative Width | 0 |



\## Interpretation



No observations violated the basic geographic ranges used for Latitude and Longitude.



No observations violated the 0–360 degree structural range used for Course Over Ground.



No negative Length or Width values were identified.



However, several values require interpretation before being classified as errors.



\### Speed Over Ground



7,275 observations were flagged by the initial SOG range check.



These observations are treated as flags rather than confirmed errors.



The analysis does not modify or remove them without sufficient evidence about the source-specific meaning of the values.



\### Length and Width



The dataset contains a substantial number of zero values for Length and Width.



Zero does not automatically mean that the vessel dimension is incorrect.



These values require interpretation using the source documentation before deciding whether they represent unknown, unavailable, default, or genuinely zero values.



\## Analytical Takeaway



Basic geographic and structural validation shows that Latitude, Longitude, COG, Length, and Width contain no negative dimension values or basic range violations of the type tested.



At the same time, several fields contain values that warrant further investigation.



The appropriate response is therefore to \*\*flag and investigate rather than automatically clean\*\*.



\---



\# Overall Analysis Findings



The three analytical questions reveal three different dimensions of data quality.



\## 1. Metadata completeness is uneven



The availability of vessel metadata varies significantly between vessel categories.



This means data-quality monitoring should consider vessel type rather than relying only on dataset-wide averages.



\## 2. Temporal continuity is mostly short but has a long tail



Most observations occur within a few minutes of the previous observation for the same vessel.



A small number of very large gaps exist and should be treated as investigation candidates.



\## 3. Structural validity is generally strong, but several fields require interpretation



Latitude, Longitude, and COG passed the basic structural checks used in this analysis.



SOG flags and zero Length/Width values require additional source-specific interpretation before they can be classified as errors.



\---



\# Limitations



This analysis is based on a selected geographic area and a limited date range:



\- Geographic area: San Pedro Bay / Los Angeles–Long Beach area

\- Date range: January 1–14, 2025

\- Source: NOAA AIS vessel-track data

\- Working observations: 2,210,745

\- Unique MMSIs: 1,039



The findings should therefore not automatically be generalized to the entire NOAA AIS dataset or to all maritime traffic.



The project also does not use Kpler proprietary data, systems, APIs, or confidential information.



The analysis is an independent portfolio project inspired by publicly documented data-quality requirements relevant to maritime market-data work.



\---



\# Next Analytical Step



The next stage is to convert these findings into final analysis outputs suitable for visualization.



The final outputs should focus on:



1\. Metadata completeness by vessel category

2\. Observation-gap distribution and long-gap cases

3\. Field-validity flags and their frequency



These outputs will provide the basis for the project's dashboard and final recommendations.

