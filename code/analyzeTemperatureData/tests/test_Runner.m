testResult_ErrorHandlingTemperature = runtests('test_ErrorHandlingTemperature');
testResult_detectOverheating = runtests('test_detectOverheating');
% Display the results of the tests
disp(testResult_ErrorHandlingTemperature);
disp(testResult_detectOverheating);

if testResult_detectOverheating.Passed == 1 
    plotOverheatingZones(temperature, timestamps, diagnostic.mask.OVERHEAT , diagnostic.regions.OVERHEAT, temperatureHardwareLimit)
end

if testResult_ErrorHandlingTemperature.Passed == 1 
    plotTemperatureData(timestamps, temperature, joint_index, joint_name)
end