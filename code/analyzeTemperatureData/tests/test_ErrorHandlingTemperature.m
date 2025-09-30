function tests = test_ErrorHandlingTemperature
% TEST_ERRORHANDLINGTEMPERATURE — Unit tests for error detection module.
tests = functiontests(localfunctions);
end

function test_errorDetection(testCase)
  
  % Build synthetic signal with all error cases
  test_signal = buildTestSignal;
  
  timestamps     = test_signal.timestamps;
  temperature    = test_signal.temperature;

  i2c_nack       = test_signal.expected.i2c_nack;
  i2c_lost_conn  = test_signal.expected.i2c_lost_conn;
  tdb_conf       = test_signal.expected.tdb_conf;
  any_tdb_conf   = test_signal.expected.any_tdb_conf;
  ovh            = test_signal.expected.ovh;
  gen_err        = test_signal.expected.gen_err;
  
  % -------------------------------
  % CI-safe: prevent askThreshold GUI from opening
  % global threshold
  % threshold = 30;  % fixed threshold for automated tests
  % -------------------------------

  % Run detection
  D = errorHandlingTemperature(timestamps, temperature);

  % Count occurrences of each mask
  FOC_TDB_I2C_NACK              = sum(D.mask.FOC_TDB_I2C_NACK);
  FOC_TDB_NO_MEAS               = sum(D.mask.FOC_TDB_NO_MEAS);
  TDB_LOST_CONFIG               = sum(D.mask.TDB_LOST_CONFIG);
  TDB_ANY_CONFIG                = sum(D.mask.TDB_ANY_CONFIG);
  OVERHEAT                      = sum(D.mask.OVERHEAT);
  GENERIC_NEGATIVE_TEMPERATURE  = sum(D.mask.GENERIC_NEGATIVE_TEMPERATURE);

  % --- Assertions ---
  verifyThatWithinTolerance(testCase, FOC_TDB_I2C_NACK, i2c_nack, 1);
  verifyThatWithinTolerance(testCase, FOC_TDB_NO_MEAS,  i2c_lost_conn, 1);
  verifyThatWithinTolerance(testCase, TDB_LOST_CONFIG,  tdb_conf, 1);
  verifyThatWithinTolerance(testCase, TDB_ANY_CONFIG,   any_tdb_conf, 1);
  verifyThatWithinTolerance(testCase, GENERIC_NEGATIVE_TEMPERATURE, gen_err, 1);

  % Overheating should match the synthetic block in buildTestSignal
  verifyThatWithinTolerance(testCase, OVERHEAT, ovh, 1);

  % -------------------------------
  % Reset threshold for other tests
  threshold = [];
  % -------------------------------

  % (Optional plotting for local debugging only)
  if ~isCI()
      figure;
      plot(timestamps, temperature)
      hold on
      plot(timestamps, (-90)*D.mask.FOC_TDB_I2C_NACK, 'DisplayName', 'FOC\_TDB\_I2C\_NACK');
      plot(timestamps, (-70)*D.mask.FOC_TDB_NO_MEAS, 'DisplayName', 'FOC\_TDB\_NO\_MEAS');
      plot(timestamps, (-50)*D.mask.TDB_LOST_CONFIG, 'DisplayName', 'TDB\_LOST\_CONFIG');
      plot(timestamps, (-30)*D.mask.TDB_ANY_CONFIG, 'DisplayName', 'TDB\_ANY_CONFIG');
      plot(timestamps, (90)*D.mask.OVERHEAT, 'DisplayName', 'OVERHEAT');
      plot(timestamps, D.mask.GENERIC_NEGATIVE_TEMPERATURE, 'DisplayName', 'GENERIC\_NEGATIVE\_TEMPERATURE')
      hold off
      legend('show');
      xlabel('Timestamps [sec]');
      ylabel('Mask Values');
      title('Error Handling Temperature Masks');
      grid on;
  end
end

% --- helper assertion ----------------------------------------------------
function verifyThatWithinTolerance(tc, actual, expected, tol)
tc.verifyLessThanOrEqual(abs(actual - expected), tol, ...
  sprintf('%.2f not within ±%.2f of %.2f', actual, tol, expected));
end

% --- CI detection helper -------------------------------------------------
function tf = isCI()
% Return true if running in CI (GitHub Actions sets CI=true)
tf = ~isempty(getenv('CI')) && strcmpi(getenv('CI'),'true');
end
