-- ============================================================
-- Maritime Data Quality Analysis
-- 02 — Metadata Completeness
-- ============================================================
--
-- Analytical Question:
--
-- How does completeness of vessel metadata vary across
-- vessel categories?
--
-- Fields examined:
-- IMO
-- Draft
-- Cargo
-- Vessel Name
-- Length
-- Width
--
-- IMPORTANT:
-- Missing values are measured, not automatically classified
-- as errors.
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

        MAX(
            CASE WHEN IMO IS NOT NULL THEN 1 ELSE 0 END
        ) AS has_imo,

        MAX(
            CASE WHEN Draft IS NOT NULL THEN 1 ELSE 0 END
        ) AS has_draft,

        MAX(
            CASE WHEN Cargo IS NOT NULL THEN 1 ELSE 0 END
        ) AS has_cargo,

        MAX(
            CASE WHEN VesselName IS NOT NULL THEN 1 ELSE 0 END
        ) AS has_vessel_name,

        MAX(
            CASE WHEN Length IS NOT NULL THEN 1 ELSE 0 END
        ) AS has_length,

        MAX(
            CASE WHEN Width IS NOT NULL THEN 1 ELSE 0 END
        ) AS has_width

    FROM vessel_data

    GROUP BY
        MMSI,
        VesselType
)

SELECT
    VesselType,

    COUNT(*) AS vessels,

    ROUND(
        100.0 * SUM(CASE WHEN has_imo = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_imo,

    ROUND(
        100.0 * SUM(CASE WHEN has_draft = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_draft,

    ROUND(
        100.0 * SUM(CASE WHEN has_cargo = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_cargo,

    ROUND(
        100.0 * SUM(CASE WHEN has_vessel_name = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_vessel_name,

    ROUND(
        100.0 * SUM(CASE WHEN has_length = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_length,

    ROUND(
        100.0 * SUM(CASE WHEN has_width = 0 THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS pct_missing_width

FROM vessel_level

GROUP BY
    VesselType

ORDER BY
    vessels DESC;