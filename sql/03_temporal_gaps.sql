-- ============================================================
-- Maritime Data Quality Analysis
-- 03 — Temporal Continuity
-- ============================================================
--
-- Analytical Question:
--
-- How consistent are vessel observation intervals, and where
-- do unusually long gaps occur?
--
-- IMPORTANT:
-- A large gap is a flag for investigation, not automatically
-- an error.
-- ============================================================


WITH vessel_times AS (

    SELECT
        MMSI,
        BaseDateTime,

        LAG(BaseDateTime) OVER (
            PARTITION BY MMSI
            ORDER BY BaseDateTime
        ) AS previous_timestamp

    FROM read_csv_auto(
        'C:/Users/nidal/Downloads/AIS_SanPedroBay_Jan01-14_2025.csv'
    )

),

gaps AS (

    SELECT
        MMSI,
        BaseDateTime,
        previous_timestamp,

        EPOCH(
            BaseDateTime - previous_timestamp
        ) / 60.0 AS gap_minutes

    FROM vessel_times

    WHERE previous_timestamp IS NOT NULL
)

SELECT
    COUNT(*) AS intervals,

    ROUND(MIN(gap_minutes), 2)
        AS min_gap_minutes,

    ROUND(MEDIAN(gap_minutes), 2)
        AS median_gap_minutes,

    ROUND(
        QUANTILE_CONT(gap_minutes, 0.90),
        2
    ) AS p90_gap_minutes,

    ROUND(
        QUANTILE_CONT(gap_minutes, 0.95),
        2
    ) AS p95_gap_minutes,

    ROUND(
        QUANTILE_CONT(gap_minutes, 0.99),
        2
    ) AS p99_gap_minutes,

    ROUND(MAX(gap_minutes), 2)
        AS max_gap_minutes

FROM gaps;