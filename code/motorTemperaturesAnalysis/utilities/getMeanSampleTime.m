function meanSampleTime = getMeanSampleTime(timestamps)
    meanSampleTime = mean(diff(timestamps));
end