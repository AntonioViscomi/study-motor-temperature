function plotTemperatureData(timestamps,temperature, joint_index, joint_name)
    %PLOTTEMPERATUREDATA Summary of this function goes here
    %   Detailed explanation goes here
    plot(timestamps, temperature)
    xlabel('Time [sec]')
    ylabel('Temperature [°C]')
    title(['Motor ', joint_index, 'of joint ', joint_name.upper], 'Interpreter', 'none')
end