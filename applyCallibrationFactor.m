function [ calibAccX, calibAccY, calibAccZ ] = applyCallibrationFactor( accX, accY, accZ, o, s )
%applyCallibrationFactor Apply the calibration factor on the accelerometers
%signals.
%   This function applies the calibration factor on the accelerometers
%   signals to obtain the acceleration withou offset and with correct scale
%   factor.
%
% Inputs:
%   accX, accY, accZ - Vectors containing the acceleration
%   o, s - Calibration facctors (offset and scale). These parameters should
%   be obtained using calibrateAccelerometer function.
% Outputs:
%   calibAccX, calibAccY, calibAccZ - the acclerometer signal with removed
%   offset and correct scale.

calibAccX = (accX - o(1))/s(1);
calibAccY = (accY - o(2))/s(2);
calibAccZ = (accZ - o(3))/s(3);

end

