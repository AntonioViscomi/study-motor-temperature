function OVERHEAT = detectOverheating(temperature, timestamps, temperatureHardwareLimit)
    
    canSpeed = 10; % [Hz]
    temperatureHardwareTimeLimit = 10; % [sec]

    meanSampleTime = getMeanSampleTime(timestamps);
    nSamples = ceil( 1/(meanSampleTime*canSpeed) ); % same as nTDBreadings = canSpeed/ethSpeed;
    requiredSamples = round(canSpeed * temperatureHardwareTimeLimit * nSamples);

    % Create binary mask for temperatures above threshold
    aboveThreshold = temperature > temperatureThreshold;
    
    % Use convolution to count consecutive samples
    consecutiveCounts = conv(double(aboveThreshold), ones(requiredSamples, 1), 'valid');
    
    % Find where we have sustained overheating (all samples in window are above threshold)
    OVERHEAT = find(consecutiveCounts == requiredSamples);
        
end