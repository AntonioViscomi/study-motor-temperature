function temperatureData = getTemperatureData(joint_name, experimentData)

    % Input validation
    if nargin < 2
        error('getJointIndex:InsufficientInputs', 'Both joint_name and experimentData are required.');
    end
    
    % Validate joint_name input
    if ~(ischar(joint_name) || isstring(joint_name)) || isempty(joint_name)
        warning('getTemperatureData:InvalidJointName', 'joint_name must be a non-empty string or char array.');
        temperatureData = NaN;
        return;
    end

    joint_idx = getJointIndex(joint_name, experimentData);
    experimentName = getExperimentName(experimentData);

    if isfield(experimentData.(experimentName).motors_state, "temperatures")
        tmp = squeeze(experimentData.(experimentName).motors_state.temperatures.data);
        temperatureData = tmp(joint_idx, :);
    else
        warning("Temperature not logged.")
        temperatureData = NaN;
    end

end