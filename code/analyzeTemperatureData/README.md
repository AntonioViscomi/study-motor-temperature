# README.md

# Temperature Analysis Diagnostics in MATLAB

This MATLAB package provides a suite of functions to analyze, visualize, and diagnose motor and sensor temperature data. It can detect overheating events, flag negative temperature diagnostic bands (including generic negative readings), and produce plots and structured Markdown reports.

## Index
- [Overview](#overview)
- [Workflow](#workflow)
- [Core Functions](#core-functions)
- [Diagnostic Bands](#diagnostic-bands)
- [Getting Started](#getting-started)
- [Contact](#contact)

## [Overview](#overview)
This repository is aimed at extracting, analyzing, and visualizing temperature signals from robot experiments, with a focus on robust handling of negative temperature codes as well as detection of persistent overheating.

## [Workflow](#workflow)
1. Load experimental data from `.mat` files and threshold using UI dialogs.
2. Select target joint.
3. Extract temperature vectors.
4. Analyze for overheating and diagnostic.
5. Visualize results & display reports.
6. Validate analysis via supplied test suite.

## [Core Functions](#core-functions)
- `detectOverheating`: Marks regions exceeding threshold for ≥10 s, returns boolean mask + intervals table.
- `errorHandlingTemperature`: Flags special diagnostic values and *generic negative values* (temp < 0 °C).
- `plotTemperatureData`, `plotOverheatingZones`: Visualization tools.
- `printDiagnosticMarkdown`: Outputs markdown tables for easy documentation.
- `main`, `test_Runner`: Example pipeline and test suite entry point.

## [Diagnostic Bands](#diagnostic-bands)
All bands are implemented in `errorHandlingTemperature`:
- **FOC\_TDB\_I2C\_NACK**: Centered at –90 °C, flags I2C NACK events.
- **FOC\_TDB\_NO\_MEAS**: Centered at –70 °C, flags missing measurements (≥10 s).
- **TDB\_LOST\_CONFIG**: Centered at –50 °C, flags configuration loss.
- **TDB\_ANY\_CONFIG**: Centered at –30 °C, flags unexpected config.
- **GENERIC\_NEGATIVE\_TEMPERATURE**: Any value < 0 °C *not* flagged by the above bands.
- **OVERHEAT**: Regions exceeding user threshold for temporal persistence.

The percentage of data in each band is computed and reported.

## [Getting Started](#getting-started)
- Add the repository to your MATLAB path (run the main script or use `includePaths`).
- Use `main` for a demonstration run.
- See [analyze_temperature_data.md](analyze_temperature_data.md) for API reference.
- Run `test_Runner` for test coverage.

## [Contact](#contact)
For issues, bug reports, or enhancement requests, please contact the repository maintainer.