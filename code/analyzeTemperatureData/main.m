% Workspace cleanup
clear, clc, close all

% Load data
addpath(genpath("../../"))
experimentData = load("data/torso_pitch_mj1_amo_aksim_peak_torque_20kg_load_1744984764.949400.mat");

% Specify the joint to consider:
joint_name = "torso_pitch_mj1_real_aksim2"; % You have to know the name of the joint you want to consider.
joint_index = getJointIndex(joint_name, experimentData);

temperature = getTemperatureData(joint_name, experimentData);
timestamps = getTimestamps(experimentData);

% plotTemperatureData(timestamps,temperature, joint_index, joint_name)

temperatureHardwareLimit = 55; % Example value
diagnostic = errorHandlingTemperature(temperature, timestamps, temperatureHardwareLimit);