-- ============================================================
-- Maritime Data Quality Analysis
-- 05 — Final Analysis Metrics
-- ============================================================
--
-- Purpose:
-- Produce the final metrics used for the ANALYZE and SHARE
-- phases of the project.
--
-- The raw CSV is never modified.
-- ============================================================


-- ============================================================
-- 1. DATASET SUMMARY
-- ============================================================

SELECT
    COUNT(*) AS total_observations,
    COUNT(DISTINCT MMSI) AS unique_vessels,
    MIN(BaseDateTime) AS first_timestamp,
    MAX(BaseDateTime) AS last_timestamp
FROM read_csv_auto(
    'C:/Users/nidal/Downloads/AIS_SanPedroBay_Jan01-14_2025.csv'
);


-- ============================================================
-- 2. METADATA COMPLETENESS BY VESSEL CATEGORY
-- ============================================================

WITH vessel_data AS (
    SELECT *
    FROM read_csv_auto(
        'C:/Users/nidal/Downloads/AIS_SanPedroBay_Jan01-14_2025.csv'
    )
),

vessel_level AS (
    SELECT
        MMSI,
        VesselType,

        MAX(CASE WHEN IMO IS NOT NULL THEN 1 ELSE 0 END) AS has_imo,
        MAX(CASE WHEN Draft IS NOT NULL THEN 1 ELSE 0 END) AS has_draft,
        MAX(CASE WHEN Cargo IS NOT NULL THEN 1 ELSE 0 END) AS has_cargo,
        MAX(CASE WHEN VesselName IS NOT NULL THEN 1 ELSE 0 END) AS has_vessel_name,
        MAX(CASE WHEN Length IS NOT NULL THEN 1 ELSE 0 END) AS has_length,
        MAX(CASE WHEN Width IS NOT NULL THEN 1 ELSE 0 END) AS has_width

    FROM vessel_data
    GROUP BY MMSI, VesselType
),

vessel_type_dictionary AS (
    SELECT * FROM (
        VALUES
            (30, 'Fishing'),
            (31, 'Towing'),
            (32, 'Towing'),
            (33, 'Dredging / Underwater Operations'),
            (34, 'Diving Operations'),
            (35, 'Military Operations'),
            (36, 'Sailing'),
            (37, 'Pleasure Craft'),
            (50, 'Pilot Vessel'),
            (51, 'Search & Rescue'),
            (52, 'Tug'),
            (53, 'Port Tender'),
            (60, 'Passenger Ship'),
            (70, 'Cargo Ship'),
            (80, 'Tanker'),
            (90, 'Other Ship')
    ) AS t(VesselType, VesselCategory)
)

SELECT
    v.VesselType AS ais_vessel_type_code,

    COALESCE(
        d.VesselCategory,
        'Other / Unclassified'
    ) AS vessel_category,

    COUNT(*) AS vessels,

    ROUND(
        100.0 * SUM(CASE WHEN v.has_imo = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_imo,

    ROUND(
        100.0 * SUM(CASE WHEN v.has_draft = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_draft,

    ROUND(
        100.0 * SUM(CASE WHEN v.has_cargo = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_cargo,

    ROUND(
        100.0 * SUM(CASE WHEN v.has_vessel_name = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_vessel_name,

    ROUND(
        100.0 * SUM(CASE WHEN v.has_length = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_length,

    ROUND(
        100.0 * SUM(CASE WHEN v.has_width = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_width

FROM vessel_level v

LEFT JOIN vessel_type_dictionary d
    ON v.VesselType = d.VesselType

GROUP BY
    v.VesselType,
    d.VesselCategory

ORDER BY
    vessels DESC;

-- ============================================================
-- 3. TEMPORAL GAP DISTRIBUTION
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

    ROUND(MIN(gap_minutes), 2) AS min_gap_minutes,

    ROUND(MEDIAN(gap_minutes), 2) AS median_gap_minutes,

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

    ROUND(MAX(gap_minutes), 2) AS max_gap_minutes

FROM gaps;


-- ============================================================
-- 4. LONG GAP COUNTS
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

        EPOCH(
            BaseDateTime - previous_timestamp
        ) / 60.0 AS gap_minutes

    FROM vessel_times

    WHERE previous_timestamp IS NOT NULL
)

SELECT
    COUNT(*) FILTER (
        WHERE gap_minutes > 15
    ) AS gaps_over_15_minutes,

    COUNT(*) FILTER (
        WHERE gap_minutes > 30
    ) AS gaps_over_30_minutes,

    COUNT(*) FILTER (
        WHERE gap_minutes > 60
    ) AS gaps_over_60_minutes,

    COUNT(*) FILTER (
        WHERE gap_minutes > 360
    ) AS gaps_over_6_hours,

    COUNT(*) FILTER (
        WHERE gap_minutes > 1440
    ) AS gaps_over_24_hours

FROM gaps;


-- ============================================================
-- 5. FIELD VALIDITY SUMMARY
-- ============================================================

SELECT

    COUNT(*) AS total_observations,

    COUNT(*) FILTER (
        WHERE LAT < -90 OR LAT > 90
    ) AS invalid_latitude,

    COUNT(*) FILTER (
        WHERE LON < -180 OR LON > 180
    ) AS invalid_longitude,

    COUNT(*) FILTER (
        WHERE SOG < 0 OR SOG > 102.2
    ) AS flagged_sog,

    COUNT(*) FILTER (
        WHERE COG < 0 OR COG > 360
    ) AS invalid_cog,

    COUNT(*) FILTER (
        WHERE Length = 0
    ) AS zero_length,

    COUNT(*) FILTER (
        WHERE Length < 0
    ) AS negative_length,

    COUNT(*) FILTER (
        WHERE Width = 0
    ) AS zero_width,

    COUNT(*) FILTER (
        WHERE Width < 0
    ) AS negative_width

FROM read_csv_auto(
    'C:/Users/nidal/Downloads/AIS_SanPedroBay_Jan01-14_2025.csv'
);