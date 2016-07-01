%Teste for calibration

accX = Respiratory_Sensor_Port_COM3_Canal_0_g_Amplitude;
accY = Respiratory_Sensor_Port_COM3_Canal_1_g_Amplitude;
accZ = Respiratory_Sensor_Port_COM3_Canal_2_g_Amplitude;

modBeforeCalibration = sqrt(accX.^2 + accY.^2 + accZ.^2);
figure;
hist(modBeforeCalibration,20);


%Calibration
[ o, s, r ] = calibrateAccelerometer( accX, accY, accZ );
%Apply the factors
[ calibAccX, calibAccY, calibAccZ ] = applyCallibrationFactor( accX, accY, accZ, o, s );

modAfterCalibration = sqrt(calibAccX.^2 + calibAccY.^2 + calibAccZ.^2);

figure;
hist(modAfterCalibration,20);


