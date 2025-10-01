# Test Suite Documentation

## Index
- [Test Runner](#test-runner)
- [Error Handling Tests](#error-handling-tests)
- [Overheating Detection Tests](#overheating-detection-tests)
- [Helper Functions](#helper-functions)
- [General Notes](#general-notes)

---

## [Test Runner](#test-runner)
- `test_Runner.m`: Entry point to run all analytic and diagnostic tests.

---

## [Error Handling Tests](#error-handling-tests)
- `test_ErrorHandlingTemperature.m`: Simulates all error bands (including generic negative temperature). Verifies correct mask assignments, percentages via tolerance checks. Intended for CI and manual review.

---

## [Overheating Detection Tests](#overheating-detection-tests)
- Synthetic tests built using functions like `buildTestSignal` ensure accurate persistent overheating marking against known sinusoid and ramp signals. Single/multiple region cases are validated.

---

## [Helper Functions](#helper-functions)
- `buildTestSignal`: Generates signals with explicit error periods and overheating regions for controlled assertions.
- Other in-test helpers provide tolerance/robustness to NaNs/missing data.

---

## [General Notes](#general-notes)
- Interactive tests prompt for data/threshold selection via GUIs (can be bypassed for CI).
- Figure outputs may be suppressed/enabled depending on automation needs.
- All error bands are covered, including band-specific and generic negative temperature values.
