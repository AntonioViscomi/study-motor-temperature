function tests = test_detectOverheating
tests = functiontests(localfunctions);
end

function test_PersistsForAtLeast10s(testCase)
  t = (0:0.02:100);
  T = 60*sin(2*pi*t/100);
  thr = 0;
  [mask, R] = detectOverheating(T, t, thr);

  pct = 100*sum(mask)/numel(T);
  verifyGreaterThan(testCase, pct, 45);
  verifyLessThan(testCase,  pct, 55);

  verifyTrue(testCase, height(R) >= 1);
end