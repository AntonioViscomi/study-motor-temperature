function [FOC_TDB_I2C_NACK, FOC_TDB_NO_MEAS, TDB_LOST_CONFIG, TDB_ANY_CONFIG] = errorHandlingTemperature(temperature)
%%
% The possible errors currently managed are the following:
%   -90 : the 2FOC cannot read from the I2C, meaning that the ACK is not received from the TDB.
%   -70 : the reading cannot be done for 10 consecutive seconds. An overheating fault is triggered.
%   -50 : the TDB loses the given configuration and uses the default one. In this case, the 2FOC restores the desired configuration.
%   -30 : the TDB sets any configuration value different from both the desired and the default one.

FOC_TDB_I2C_NACK = temperature(temperature >= -90 & temperature < -70);
FOC_TDB_NO_MEAS = temperature(temperature >= -70 & temperature < -50);
TDB_LOST_CONFIG = temperature(temperature >= -50 & temperature < -30);
TDB_ANY_CONFIG = temperature(temperature >= -30 & temperature < -10);

end