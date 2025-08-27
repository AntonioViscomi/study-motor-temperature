function OVERHEAT = detectOverheating(temperature, timestamps, temperatureHardwareLimit)

    n = length(temperature);
    OVERHEAT = zeros(1, n);

    overheatTimeLimit = 10; % [sec]

    meanSampleTime = getMeanSampleTime(timestamps); % [sec]
    requiredSamples = ceil(overheatTimeLimit / meanSampleTime);

    % Find transitions: where temperature crosses the threshold
    aboveThreshold = temperature > temperatureHardwareLimit;
    transitions = diff([false, aboveThreshold, false]); % removes equal consecutive values leaving only state change.
    
    % Find start and end indices of above-threshold regions
    startIndices = find(transitions == 1);
    endIndices = find(transitions == -1) - 1;

    % Compute region lengths for all indices at once
    regionLengths = endIndices - startIndices + 1;

    % Find valid regions
    validMask = regionLengths >= requiredSamples;

    % Extract the valid start and end indices
    validStarts = startIndices(validMask);
    validEnds   = endIndices(validMask);

    % Assign vectorized updates
    OVERHEAT(validStarts) =  1;
    OVERHEAT(validEnds)   = -1;
   
end