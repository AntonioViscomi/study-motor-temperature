function processData(experimentData, joint_name)

    temperature = getTemperatureData(joint_name, experimentData);
    
    timestamps = getTimestamps(experimentData);
    
    diagnostic = errorHandlingTemperature(timestamps, temperature);
    
    displayReport(timestamps, temperature, diagnostic);

end