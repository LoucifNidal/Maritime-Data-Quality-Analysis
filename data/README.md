# Data

## Working Dataset

This project analyzes a selected subset of publicly available NOAA AIS vessel-track data.

### Source

**Provider:** NOAA / U.S. Coast Guard AIS

**Dataset:** AIS Vessel Tracks 2025

**Official source:**  
https://catalog.data.gov/dataset/ais-vessel-tracks-2025

The project uses AIS broadcast-point data collected through the U.S. Coast Guard national AIS receiver network.

---

## Geographic Scope

The working dataset covers the San Pedro Bay / Los Angeles–Long Beach area.

### Bounding Box

**Top-left:**

- Longitude: -118.40
- Latitude: 33.85

**Bottom-right:**

- Longitude: -117.85
- Latitude: 33.60

---

## Time Scope

The working analysis covers:

**January 1, 2025 – January 14, 2025**

The working dataset contains observations from:

`2025-01-01 00:00:00`

through:

`2025-01-14 23:59:59`

---

## Working File

The analysis was performed using:

`AIS_SanPedroBay_Jan01-14_2025.csv`

The working file contains:

- 2,210,745 observations
- 1,039 unique MMSIs
- 17 columns

The raw CSV is not modified during analysis.

---

## Main Fields

The dataset contains the following fields:

- MMSI
- BaseDateTime
- LAT
- LON
- SOG
- COG
- Heading
- VesselName
- IMO
- CallSign
- VesselType
- Status
- Length
- Width
- Draft
- Cargo
- TransceiverClass

---

## Data Preparation

The original NOAA data was obtained through the NOAA AccessAIS workflow using the geographic and date selection described above.

A working subset was created for analysis.

The raw source data was preserved separately and the working CSV was analyzed using DuckDB.

No values were overwritten in the raw dataset.

---

## Important Data-Quality Principle

Missing, zero, unusual, or flagged values are not automatically treated as errors.

The project distinguishes between:

- Missing values
- Potential unknown/default values
- Validation flags
- Confirmed invalid values

Source documentation is used where possible before classifying a value as invalid.

---

## Reproducibility

The SQL analysis scripts are stored in:

`../sql/`

Current scripts:

- `01_profile.sql`
- `02_metadata_quality.sql`
- `03_temporal_gaps.sql`
- `04_validity_checks.sql`
- `05_final_metrics.sql`

The large CSV is intentionally not included in the project repository.

The project documents the source, geographic selection, date range, fields, processing approach, and SQL workflow so that the analysis can be reproduced using the same source selection.

---

