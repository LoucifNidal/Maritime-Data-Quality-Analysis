-- ============================================================
-- Maritime Data Quality Analysis
-- 04 — Field Validity Checks
-- ============================================================
--
-- Analytical Question:
--
-- Are there records containing potentially invalid or
-- anomalous values in key movement and vessel-characteristic
-- fields?
--
-- IMPORTANT:
-- A flagged record is NOT automatically an erroneous record.
-- These checks identify values requiring interpretation or
-- further validation.
-- ============================================================


SELECT

    COUNT(*) AS total_rows,

    -- --------------------------------------------------------
    -- Position validity
    -- --------------------------------------------------------

    COUNT(*) FILTER (
        WHERE LAT < -90 OR LAT > 90
    ) AS invalid_lat,

    COUNT(*) FILTER (
        WHERE LON < -180 OR LON > 180
    ) AS invalid_lon,


    -- --------------------------------------------------------
    -- Movement validity
    -- --------------------------------------------------------

    COUNT(*) FILTER (
        WHERE SOG < 0 OR SOG > 102.2
    ) AS flagged_sog,

    COUNT(*) FILTER (
        WHERE COG < 0 OR COG > 360
    ) AS invalid_cog,


    -- --------------------------------------------------------
    -- Vessel dimensions
    -- --------------------------------------------------------

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