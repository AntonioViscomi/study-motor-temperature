function timestamps = getTimestamps(experimentData)

    experimentName = getExperimentName(experimentData);

    if isempty(experimentData.(experimentName)) || ~isfield(experimentData.(experimentName), 'motors_state') || ~isfield(experimentData.(experimentName).motors_state, 'positions') || ~isfield(experimentData.(experimentName).motors_state.positions, 'timestamps')
        timestamps = [];
        return;
    end

    timestamps = experimentData.(experimentName).motors_state.positions.timestamps;
    
    if ~isempty(timestamps)
        timestamps = timestamps - timestamps(1);
    end
    
end