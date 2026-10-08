-- ============================================================
-- Maritime Data Quality Analysis
-- 01 — Dataset Profile
-- ============================================================

-- Purpose:
-- Establish the basic size and time coverage of the dataset.

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT MMSI) AS unique_vessels,
    MIN(BaseDateTime) AS first_timestamp,
    MAX(BaseDateTime) AS last_timestamp
FROM read_csv_auto(
    'C:/Users/nidal/Downloads/AIS_SanPedroBay_Jan01-14_2025.csv'
);