% Workspace cleanup
clear, clc, close all

% Load data
[experimentName, experimentPath] = uigetfile('\study-motor-temperature\data', '*.mat');
experimentData = load([experimentPath experimentName]);

clear experimentName experimentPath

% Specify the joint to consider:
joint_name = "torso_pitch_mj1_real_aksim2"; % You have to know the name of the joint you want to consider.
joint_index = getJointIndex(joint_name, experimentData);

temperature = getTemperatureData(joint_name, experimentData);
timestamps = getTimestamps(experimentData);

plotTemperatureData(timestamps,temperature, joint_index, joint_name)

temperatureHardwareLimit = 55; % Example value
diagnostic = errorHandlingTemperature(temperature, timestamps, temperatureHardwareLimit);