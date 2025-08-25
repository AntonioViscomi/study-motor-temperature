function plotTemperatureData(timestamps,temperature)
%PLOTTEMPERATUREDATA Summary of this function goes here
%   Detailed explanation goes here
plot(timestamps, temperature)
xlabel('Time [sec]')
ylabel('Temperature [°C]')
title(['Temperature for motor ', 'mot_ num ', 'of ', 'joint ', 'joint_ name'])
end