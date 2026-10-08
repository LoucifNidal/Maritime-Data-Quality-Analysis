# 06 — Act

## Purpose

The purpose of this phase is to translate the analytical findings into practical
next steps for further investigation and data-quality improvement.

Because this is an independent portfolio project, the recommendations are presented
as analytical recommendations rather than instructions to Kpler or any other
organization.

---

## Recommendation 1 — Establish vessel-category-specific quality monitoring

### Finding

Metadata completeness varies substantially between vessel categories.

### Recommended Action

Monitor completeness metrics separately by vessel category rather than relying only
on an overall dataset completeness score.

For example, IMO, Draft and Cargo completeness could be tracked independently for:

- Pleasure Craft
- Sailing vessels
- Passenger vessels
- Cargo vessels
- Tankers
- Towing vessels
- Tug vessels
- Other categories

### Why

A single quality threshold may hide important differences between vessel categories.

Category-level monitoring makes it easier to identify where metadata quality is
strong and where additional validation may be required.

---

## Recommendation 2 — Investigate long observation gaps

### Finding

The typical observation interval is short, but a small number of vessels contain
very large gaps.

### Recommended Action

Create a repeatable long-gap monitoring rule that identifies unusually long
observation intervals for individual vessels.

Potential follow-up analysis could examine:

- Vessel identity
- Vessel type
- Timestamp before the gap
- Timestamp after the gap
- Geographic position before and after the gap
- Duration of the gap
- Whether similar gaps occur repeatedly for the same vessel

### Why

Large gaps can affect the continuity of vessel tracking and may require investigation
before being used in downstream analytical products.

A gap should not automatically be classified as an error without understanding its
cause.

---

## Recommendation 3 — Validate anomalous movement and vessel-characteristic values

### Finding

The screening identified:

- 7,275 observations flagged by the SOG check
- 66,619 zero Length records
- 93,538 zero Width records

### Recommended Action

Before modifying or removing these records, compare the flagged values with the
source-system definitions and AIS domain rules.

The next validation stage should determine whether these values represent:

- Legitimate observations
- Unavailable information
- Default values
- Sentinel values
- Transmission or processing issues
- Genuine anomalous records

### Why

Automatically cleaning these records could remove legitimate information or
introduce incorrect assumptions into the dataset.

---

## Recommendation 4 — Turn the checks into repeatable data-quality metrics

The current analysis demonstrates three reusable quality dimensions:

### Completeness

Are important vessel attributes populated?

### Continuity

Are vessel observations sufficiently continuous?

### Validity

Do values fall within structurally acceptable ranges?

These dimensions could be converted into a recurring monitoring framework in which
quality metrics are calculated for each new dataset or reporting period.

---

## Recommended Next Analytical Step

The next stage of this project would be to expand the analysis beyond screening and
investigate the causes behind the highest-priority flags.

Examples include:

- Investigating the largest observation gaps spatially
- Comparing gap frequency by vessel category
- Examining whether long gaps cluster around particular locations
- Validating SOG flags against AIS source semantics
- Investigating the meaning of zero Length and Width values
- Measuring data quality across additional time periods

These analyses were intentionally kept outside the current project scope so that the
portfolio project remains focused on three clearly defined analytical questions.

---

## Final Takeaway

The analysis demonstrates that data quality should be evaluated as a measurable,
multi-dimensional process rather than as a simple "clean" or "unclean" classification.

The workflow developed in this project can be summarized as:

**Profile → Measure → Investigate → Validate → Monitor**

This approach provides a foundation for building repeatable data-quality monitoring
workflows for maritime datasets.