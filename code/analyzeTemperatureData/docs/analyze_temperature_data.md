# Temperature Data Analysis Documentation

## Index
- [Diagnostics](#diagnostics)
    - [detectOverheating](#detectoverheating)
    - [errorHandlingTemperature](#errorhandlingtemperature)
    - [Diagnostic Bands](#diagnostic-bands)
- [Data Extraction](#data-extraction)
    - [getExperimentName](#getexperimentname)
    - [getJointIndex](#getjointindex)
    - [getTemperatureData](#gettemperaturedata)
    - [getTimestamps](#gettimestamps)
    - [getMeanSampleTime](#getmeansampletime)
- [Utilities & UI](#utilities--ui)
    - [askThreshold](#askthreshold)
    - [askJointName](#askjointname)
    - [displayReport](#displayreport)
    - [printDiagnosticMarkdown](#printdiagnosticmarkdown)
    - [includePaths](#includepaths)
- [Visualization](#visualization)
    - [plotTemperatureData](#plottemperaturedata)
    - [plotOverheatingZones](#plotoverheatingzones)
- [Workflow](#workflow)
    - [main](#main)
    - [processData](#processdata)
    - [loadData](#loaddata)

---

## [Diagnostics](#diagnostics)

### [detectOverheating](#detectoverheating)
Detects all contiguous intervals where temperature exceeds a user-specified threshold for at least 10 seconds. Returns:
- `mask`: logical vector (true for overheating samples)
- `regions`: table with `startIdx`, `endIdx`, `length` (samples) for each valid region.

Handles both double and datetime vectors for time, auto-normalizes and computes minimum sample count for persistence. The threshold can be set using `askThreshold`.

Example:

```matlab
[mask, regions] = detectOverheating(timestamps, temperature)
```


---

### [errorHandlingTemperature](#errorhandlingtemperature)
Identifies all samples falling into defined negative diagnostic bands (centered at –90 °C, –70 °C, –50 °C, –30 °C) and those *generically* less than 0 °C (excluding the above). Returns:
- `mask.<band>`: logical vector for each diagnostic (see below)
- `mask.GENERIC\_NEGATIVE\_TEMPERATURE`: logical mask for samples < 0 °C, not assigned to other diagnostic bands.
- `mask.OVERHEAT`: logical mask from persistent threshold violation.
- `percentage.<band>`: Percentage for each band and for OVERHEAT.
- `regions.OVERHEAT`: Table from persistent detection.


```matlab
diagnostic = errorHandlingTemperature(timestamps, temperature)
```


#### [Diagnostic Bands](#diagnostic-bands)
- **FOC_TDB_I2C_NACK** (`mask.FOCTDBI2CNACK`): I2C NACK band at –90 °C.
- **FOC_TDB_NO_MEAS** (`mask.FOCTDBNOMEAS`): No measurement band at –70 °C.
- **TDB_LOST_CONFIG** (`mask.TDBLOSTCONFIG`): Configuration lost at –50 °C.
- **TDB_ANY_CONFIG** (`mask.TDBANYCONFIG`): Unexpected config at –30 °C.
- **GENERIC_NEGATIVE_TEMPERATURE** (`mask.GENERICNEGATIVETEMPERATURE`): All negative data not assigned above.
- **OVERHEAT** (`mask.OVERHEAT`): Temporal threshold excess.

Percentages are included in `diagnostic.percentage`.

---

## [Data Extraction](#data-extraction)

### [getExperimentName](#getexperimentname)
Returns the root/top-level experiment field name from a loaded data struct.

### [getJointIndex](#getjointindex)
Returns the row index of specified joint in the description list.

### [getTemperatureData](#gettemperaturedata)
Retrieves the temperature vector for the given joint, returns NaN if missing.

### [getTimestamps](#gettimestamps)
Returns time vector, normalized to zero at start.

### [getMeanSampleTime](#getmeansampletime)
Computes and returns mean sampling interval.

---

## [Utilities & UI](#utilities--ui)

### [askThreshold](#askthreshold)
Displays a modal GUI to set an overheating threshold (0–200 °C), auto-centers on your active monitor.

### [askJointName](#askjointname)
Modal GUI for entering/selecting joint label; supports keyboard/validation/cancellation.

### [displayReport](#displayreport)
Aggregates plotting and diagnostic reporting in one call.

### [printDiagnosticMarkdown](#printdiagnosticmarkdown)
Prints ASCII/Markdown tables showing band percentages and overheating region details.

### [includePaths](#includepaths)
Recursively adds all repo folders to MATLAB path.

---

## [Visualization](#visualization)

### [plotTemperatureData](#plottemperaturedata)
Plots temperature versus time, with dynamic titles and labeling.

### [plotOverheatingZones](#plotoverheatingzones)
Overlays detected overheating periods on the temperature plot, color-coded/highlighted.

---

## [Workflow](#workflow)

### [main](#main)
Demo script showing extraction, analysis, and visualization pipeline.

### [processData](#processdata)
Core workflow: temperature/time data extraction, computation of diagnostics, outputs via plotting/report.

### [loadData](#loaddata)
Interactive file selector for importing experimental `.mat` data.