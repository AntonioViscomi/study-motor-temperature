% MAIN — Example driver for the temperature analysis pipeline.
%
% Syntax:
%   main
%
% Description:
%   Demonstrates typical usage of the analysis functions:
%   - load/prepare timestamps (here synthetic for demo)
%   - compute diagnostics, plot data and overheating zones
%   - print a Markdown table with percentages
%
% Example:
%   main

% --- Demo data (replace with your I/O as needed) -------------------------
% Example: 250 s of data at ~0.5 Hz equivalent with a smooth sinusoid
% timestamps = (0:0.5:250);                   % seconds (numeric) for demo
% temperature = 95*sin(2*pi*timestamps/250);   % °C, synthetic
% temperatureHardwareLimit = 0;                % Example threshold (°C)

addpath(genpath('.'))
%%
% Load data
% [experimentName, experimentPath] = uigetfile({'*.mat','Data Files (*.mat)'});
% experimentData = load([experimentPath experimentName]);
% clear experimentName experimentPath
% 
% % Specify the joint to consider:
% joint_name  = "torso_pitch_mj1_real_aksim2"; % You have to know the name of the joint you want to consider.
% joint_index = getJointIndex(joint_name, experimentData);

temperatureHardwareLimit = 55;

temperature = getTemperatureData(joint_name, experimentData);
timestamps  = getTimestamps(experimentData);

timestamps = (0:0.5:250);                   % seconds (numeric) for demo
temperature = 95*sin(2*pi*timestamps/82);   % °C, synthetic
temperatureHardwareLimit = 0;                % Example threshold (°C)

% --- Visualize raw temperature vs time -----------------------------------
plotTemperatureData(timestamps, temperature, joint_index, joint_name);

% --- Compute diagnostics (includes overheating) --------------------------
diagnostic = errorHandlingTemperature(temperature, timestamps, ...
                                      temperatureHardwareLimit);

% --- Print a Markdown report to the console ------------------------------
buildMarkDownTable(diagnostic);

% --- Overlay overheating zones on the temperature plot -------------------
plotOverheatingZones(temperature, timestamps, ...
                     diagnostic.mask.OVERHEAT, diagnostic.regions.OVERHEAT, ...
                     temperatureHardwareLimit);