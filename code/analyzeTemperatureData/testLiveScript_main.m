%[text] Using this live script you can easily use this set of scripts to analyze the temperature measurements of motors. There's no need to touch these lines of code.
% Workspace cleanup
clear, clc, close all

% Include necessary folders
addpath(genpath("../../"))
%[text] Here you can write down the experiment relative path. It can be located everywhere inside "**study-motor-temperature**", but a best practice would be locating the file inside the *"study-motor-temperature/****data****"* folder.
experimentName = "data/torso_pitch_mj1_amo_aksim_peak_torque_20kg_load_1744984764.949400.mat";

experimentData = load(experimentName);
%[text] The you must specify the name of the joint, which is associated with a single motor (e.g., r\_ankle\_roll consider the motor generating the roll motion of the robot's right ankle.)
%[text] *Actually, this could be a problem when considering closed chain kinematics mechanism, such as the S-P-U ankle.*
% Specify the joint to consider:
joint_name = "torso_pitch_mj1_real_aksim2"; % You have to know the name of the joint you want to consider.

joint_index = getJointIndex(joint_name, experimentData);
%[text] If you want to both quantitatively analyze the data and/or plot it, you need some sort of time-scale, this command retrieves it.
timestamps = getTimestamps(experimentData);
%[text] Then, you get the temperature data associated to the motor of the specified joint:
temperature = getTemperatureData(joint_name, experimentData);
%[text] If you want to check the diagnostic, you can use the following function, which creates a struct containing the following fields:
%[text] - mask: Index where the error is located. It can be used alongside the timestamps to determine when the considered error happened.
%[text] - percentage: How many time a specific error happened during the experiment. \
%[text] ### *TO DO:*
%[text] - *Add the chance to select a specific portion of the whole experiment for the analysis* \
temperatureHardwareLimit = 55; % Example value
diagnostic = errorHandlingTemperature(temperature, timestamps, temperatureHardwareLimit);
%[text] Inside the fields of the diagnostic struct you will find the following sub-fields: 
%[text] - FOC\_TDB\_I2C\_NACK
%[text] - FOC\_TDB\_NO\_MEAS
%[text] - TDB\_LOST\_CONFIG
%[text] - TDB\_ANY\_CONFIG
%[text] - OVERHEAT \
%[text] The errors are documented here:
%[text] - [iCub Tech Docs - Motor Temperature Data Flow](https://icub-tech-iit.github.io/documentation/temperature_sensors/software/dataflow/#main-flow-of-information:~:text=The%20possible%20errors%20currently%20managed%20are%20the%20following%3A) \
%[text] Additionally, you can print out a markdown-table (e.g. you can copy and paste it anywhere on github!)
% TODO:
%Define a function that prints out a markdown table

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline","rightPanelPercent":22.7}
%---
