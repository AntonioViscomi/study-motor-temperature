function  test_signal = buildTestSignal()
    % Parameters (as example)
    fs = 500;  % sampling frequency in Hz (2FOC reads at 10 Hz)  
    T = 60;   % total duration in seconds  
    timestamps = (0:(1/fs):T)';  % time vector
    
    % Preallocate
    N = length(timestamps);
    temperature = zeros(N,1);

    % Useful temperature values
    T_env = 25;
    T_ovh = 90;
    
    % Error codes:
    I2C_ERR = -90;
    CONN_ERR = -70;
    TDB_CONF_ERR = -50;
    TDB_ANY_CONF_ERR = -30;
    
    % Fill temperature with standard value
    temperature(:) = T_env;

    %% Introduce segments corresponding to each error:
    
    % 1) ACK fail (−90): e.g. from t = 5 to 8 seconds
    idx = (timestamps >=5 & timestamps <8);
    i2c_nack = sum(idx);
    temperature(idx) = I2C_ERR;
    
    % 2) 10s consecutive missing reading (−70): from t = 10 to 20
    idx = (timestamps >=10 & timestamps <20);
    i2c_lost_conn = sum(idx);
    temperature(idx) = CONN_ERR;

    % 3) config lost to default (−50): from t = 25 to 28
    idx = (timestamps >=25 & timestamps <28);
    tdb_conf = sum(idx);
    temperature(idx) = TDB_CONF_ERR;

    % 4) config corrupted (−30): from t = 30 to 33
    idx = (timestamps >=30 & timestamps <33);
    any_tdb_conf = sum(idx);
    temperature(idx) = TDB_ANY_CONF_ERR;

    % 5) Test overheating: from t = 35 to 47
    idx = (timestamps >=35 & timestamps <47);
    ovh = sum(idx);
    temperature(idx) = T_ovh; 
    
    % 6) hardware fault: generic negative value, from t = 48 to 55
    idx = (timestamps >= 48 & timestamps < 55);
    gen_err = sum(idx);
    GEN_ERR = -5 * abs(rand(gen_err, 1));
    temperature(idx) = GEN_ERR;
    
    
    test_signal.timestamps = timestamps;
    test_signal.temperature = temperature;

    test_signal.expected.i2c_nack = i2c_nack;
    test_signal.expected.i2c_lost_conn = i2c_lost_conn;
    test_signal.expected.tdb_conf = tdb_conf;
    test_signal.expected.any_tdb_conf = any_tdb_conf;
    test_signal.expected.ovh = ovh;
    test_signal.expected.gen_err = gen_err;

end