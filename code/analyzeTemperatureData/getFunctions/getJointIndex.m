function joint_idx = getJointIndex(joint_name, experimentData)
% GETJOINTINDEX - Returns the row index of the data corresponding to the specified joint name.
%
% This function searches for a joint name in the experiment data's description list
% and returns its corresponding index.
%
% Syntax:
%   joint_idx = getJointIndex(joint_name, experimentData)
%
% Inputs:
%   joint_name (string/char) - The name of the joint to look for in the description list
%   experimentData (struct)  - Experiment data structure containing robot_logger_device.description_list
%
% Outputs:
%   joint_idx (double) - The index (row number) of the joint in the experiment data
%                       Returns NaN if joint not found or input is invalid
%
% Example:
%   idx = getJointIndex('neck_pitch', expData);  % Returns 1 (typically)
%   idx = getJointIndex('NECK_PITCH', expData);  % Also returns 1 (case-insensitive)

    % Input validation
    if nargin < 2
        error('getJointIndex:InsufficientInputs', 'Both joint_name and experimentData are required.');
    end
    
    % Validate joint_name input
    if ~(ischar(joint_name) || isstring(joint_name)) || isempty(joint_name)
        warning('getJointIndex:InvalidJointName', 'joint_name must be a non-empty string or char array.');
        joint_idx = NaN;
        return;
    end

    % Determine current experiment name
    experimentName = getExperimentName(experimentData);
    
    % Access the list of joint descriptions from the experiment data structure
    description_list = experimentData.(experimentName).description_list;
    
    % Perform case-insensitive search
    joint_idx = find(strcmpi(joint_name, description_list));
    
    % Handle case where joint is not found
    if isempty(joint_idx)
        warning('Joint "%s" not found in description list.\n', joint_name);
        user_choice = input('Display available joints? (y/n): ', 's');
        if strcmpi(user_choice, 'y') || strcmpi(user_choice, 'yes')
            fprintf('Available joints:\n');
            for i = 1:length(description_list)
                fprintf('  %d: %s\n', i, description_list{i});
            end
        end
        joint_idx = NaN;
    end
end