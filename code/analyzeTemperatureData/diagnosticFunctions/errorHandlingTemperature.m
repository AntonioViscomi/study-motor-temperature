function diagnostic = errorHandlingTemperature(temperature, timestamps, temperatureHardwareLimit)
%%
% The possible errors currently managed are the following:
%   -90 : the 2FOC cannot read from the I2C, meaning that the ACK is not received from the TDB.
%   -70 : the reading cannot be done for 10 consecutive seconds. An overheating fault is triggered.
%   -50 : the TDB loses the given configuration and uses the default one. In this case, the 2FOC restores the desired configuration.
%   -30 : the TDB sets any configuration value different from both the desired and the default one.

diagnostic.mask.FOC_TDB_I2C_NACK = (temperature >= -90 & temperature < -70);
diagnostic.mask.FOC_TDB_NO_MEAS = (temperature >= -70 & temperature < -50);
diagnostic.mask.TDB_LOST_CONFIG = (temperature >= -50 & temperature < -30);
diagnostic.mask.TDB_ANY_CONFIG = (temperature >= -30 & temperature < -10);

diagnostic.mask.OVERHEAT = detectOverheating(temperature, timestamps, temperatureHardwareLimit);

diagnostic.percentage.FOC_TDB_I2C_NACK = 100 .* sum(diagnostic.mask.FOC_TDB_I2C_NACK) ./ length(temperature);
diagnostic.percentage.FOC_TDB_NO_MEAS = 100 .* sum(diagnostic.mask.FOC_TDB_NO_MEAS) ./ length(temperature);
diagnostic.percentage.TDB_LOST_CONFIG = 100 .* sum(diagnostic.mask.TDB_LOST_CONFIG) ./ length(temperature);
diagnostic.percentage.TDB_ANY_CONFIG = 100 .* sum(diagnostic.mask.TDB_ANY_CONFIG) ./ length(temperature);

diagnostic.percentage.OVERHEAT = 100 .* sum(diagnostic.mask.OVERHEAT) ./ length(temperature);

end