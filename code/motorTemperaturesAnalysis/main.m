% Workspace cleanup
clear, clc, close all

% Load data
addpath(genpath("../../"))
experimentData = load("data/torso_pitch_mj1_amo_aksim_peak_torque_20kg_load_1744984764.949400.mat");

% Specify the joint to consider:
joint_name = "torso_pitch_mj1_real_aksim2"; 
joint_index = getJointIndex(joint_name, experimentData);

temperature = getTemperatureData(joint_name, experimentData);
timestamps = getTimestamps(experimentData);

% plotTemperatureData(timestamps,temperature, joint_index, joint_name)

[FOC_TDB_I2C_NACK, FOC_TDB_NO_MEAS, TDB_LOST_CONFIG, TDB_ANY_CONFIG] = diagnosticTemperature(temperature);