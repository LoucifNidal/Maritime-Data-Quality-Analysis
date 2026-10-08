\# 05 — Share



\## Purpose



The purpose of this phase is to communicate the results of the analysis in a clear,

reproducible and decision-oriented format.



Because this is an independent portfolio project, the analysis was not commissioned

by Kpler and no internal stakeholder requirements were provided.



The findings will therefore be presented as an independent assessment of data-quality

patterns found in publicly available AIS vessel-track data.



\---



\## Key Findings



\### 1. Metadata completeness varies substantially by vessel category



The analysis shows significant differences in metadata completeness between vessel

categories.



Cargo ships and tankers show very high completeness for the selected metadata fields,

while categories such as Pleasure Craft and Sailing vessels show substantially lower

completeness for IMO, Draft and Cargo information.



This indicates that data completeness should not necessarily be evaluated using a

single overall quality threshold. Different vessel categories may require different

quality expectations and validation rules.



\---



\### 2. Most observation intervals are relatively short, but long gaps exist



The median interval between consecutive observations for the same vessel is

approximately 3 minutes.



The 90th percentile is approximately 6 minutes, the 95th percentile is approximately

9 minutes, and the 99th percentile is approximately 18 minutes.



However, some vessels contain much longer gaps, with the largest observed gap being

approximately 19,306 minutes.



These long gaps are treated as investigation candidates rather than automatically

classified as data errors.



\---



\### 3. Structural validity checks identify several groups of records requiring review



The structural checks found:



\- 0 invalid latitude values

\- 0 invalid longitude values

\- 0 invalid COG values

\- 7,275 observations flagged by the SOG screening rule

\- 66,619 records with zero Length

\- 93,538 records with zero Width

\- 0 negative Length values

\- 0 negative Width values



These results should not be interpreted as confirmed data errors.



Some values may represent missing, unavailable, default or otherwise valid source

semantics. Further validation against the source documentation and domain rules is

required before corrective action is taken.



\---



\## Communication Approach



The final results will be communicated through three layers:



\### 1. Executive-level summary



A concise overview will present:



\- Dataset size

\- Number of vessels

\- Study period

\- Main data-quality findings

\- Key recommendations



This allows a reader to understand the project without reviewing the underlying SQL.



\### 2. Interactive visualization



An interactive dashboard will be developed in Tableau to allow users to explore:



\- Metadata completeness by vessel category

\- Observation-gap statistics

\- Long-gap vessels

\- Potential validity flags



The Tableau dashboard will serve as the primary visual presentation of the project.



\### 3. Technical reproducibility



The repository will contain:



\- SQL analysis scripts

\- Data preparation documentation

\- Vessel-type reference documentation

\- Exported analytical results

\- R/Shiny dashboard code



This allows the analytical workflow to be inspected and reproduced.



\---



\## Visualization Plan



The final Tableau presentation will focus on a small number of decision-oriented

visualizations rather than displaying every available metric.



Planned visual components include:



1\. Dataset overview KPIs

2\. Metadata completeness by vessel category

3\. Observation-gap distribution

4\. Longest observed observation gaps

5\. Structural validity flags

6\. A concise summary of the main findings



The objective is to make the analysis understandable without requiring the reader

to inspect the raw AIS dataset.



\---



\## Important Interpretation Principle



The analysis distinguishes between:



\- Confirmed structural violations

\- Potential anomalies

\- Missing or incomplete metadata

\- Values requiring domain interpretation



This distinction is important because data-quality analysis should not automatically

treat every unusual value as an error.



\---



\## Independence and Scope



This project is an independent portfolio analysis using publicly available AIS data.



It does not use Kpler proprietary data, systems, APIs or confidential information.



The connection to Kpler is limited to the relevance of the analytical workflow to

publicly described maritime market-data and data-quality activities.



The results should therefore be interpreted as an independent demonstration of

data-analysis and data-quality skills rather than an assessment of Kpler's internal

data.

