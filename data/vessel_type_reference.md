# AIS Vessel Type Reference

## Purpose

This file documents the relationship between the original AIS `VesselType` codes and the human-readable categories used in this project.

The original numeric AIS code is retained in the analysis so that the results remain traceable to the source data.

The analytical category is used to make the results easier to understand in charts and reports.

---

## Vessel Type Mapping

| AIS Code | AIS Vessel Type | Analytical Category |
|---:|---|---|
| 30 | Fishing | Fishing |
| 31 | Towing | Towing |
| 32 | Towing | Towing |
| 33 | Dredging / Underwater Operations | Special Operations |
| 34 | Diving Operations | Special Operations |
| 35 | Military Operations | Special Operations |
| 36 | Sailing | Sailing |
| 37 | Pleasure Craft | Pleasure Craft |
| 50 | Pilot Vessel | Pilot Vessel |
| 51 | Search & Rescue | Search & Rescue |
| 52 | Tug | Tug |
| 53 | Port Tender | Port Tender |
| 60 | Passenger Ship | Passenger Ship |
| 70 | Cargo Ship | Cargo Ship |
| 80 | Tanker | Tanker |
| 90 | Other Ship | Other Ship |

---

## Handling of Unmapped Codes

AIS codes not explicitly mapped in the analysis are retained as their original numeric value and grouped under:

`Other / Unclassified`

This prevents unknown codes from being silently assigned to an incorrect category.

---

## Analytical Principle

The original AIS `VesselType` value is never overwritten.

The mapping is only used to create a human-readable analytical category.

This preserves traceability between:

`Source data → AIS code → Analytical category → Finding`

---

## Source

The vessel-type classification is based on the AIS vessel-type coding used by NOAA / U.S. Coast Guard AIS documentation.

Official AIS documentation:

https://www.navcen.uscg.gov/ais-class-a-static-voyage-message-5

The project uses these definitions only to interpret the public NOAA AIS dataset.

---

## Important Note

The analytical categories are created for portfolio analysis and visualization.

They should not be interpreted as replacing the original AIS classification system.