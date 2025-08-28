function tests = test_ErrorHandlingTemperature
% TEST_ERRORHANDLINGTEMPERATURE — Unit tests for band masks & overheating.
tests = functiontests(localfunctions);
end

function test_bandsSumCloseToExpected(testCase)
  % Ramp from 0 to -100 °C evenly mapped over time
  t = 0:0.002:100;
  T = -t;  % °C
  thr = 55;  % well above the signal (no overheating)
  D = errorHandlingTemperature(T, t, thr);

  p = D.percentage;
  % Four adjacent bands of width 20 °C each across [-90,-10] (~80 °C span)
  % Expect roughly 20% each; tolerate numerical edge effects.
  verifyThatWithinTolerance(testCase, p.FOC_TDB_I2C_NACK, 20, 3);
  verifyThatWithinTolerance(testCase, p.FOC_TDB_NO_MEAS,  20, 3);
  verifyThatWithinTolerance(testCase, p.TDB_LOST_CONFIG,  20, 3);
  verifyThatWithinTolerance(testCase, p.TDB_ANY_CONFIG,   20, 3);

  % No overheating expected
  verifyLessThanOrEqual(testCase, p.OVERHEAT, 0.1);
end

% --- helper assertion ----------------------------------------------------
function verifyThatWithinTolerance(tc, actual, expected, tol)
tc.verifyLessThanOrEqual(abs(actual - expected), tol, ...
  sprintf('%.2f not within ±%.2f of %.2f', actual, tol, expected));
end
