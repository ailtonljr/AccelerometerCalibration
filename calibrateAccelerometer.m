function [ o, s, r ] = calibrateAccelerometer( accX, accY, accZ )
%calibrateAcelerometer calculate the acceleration calibration parameters
%using the method described by Gietzelt et al.
%   Calculate the accelerometers calibration parameters from tilt data
%   using the method described in the following article:
%   Gietzelt, M., Wolf, K. H., Marschollek, M., & Haux, R. (2013). 
%   Performance comparison of accelerometer calibration algorithms based 
%   on 3D-ellipsoid fitting methods. Computer Methods and Programs in 
%   Biomedicine, 111(1), 62?71. http://doi.org/10.1016/j.cmpb.2013.03.006
%
% Parameters
%    accX, accY, accZ - vector containing the accelerometers samples for
%    each axis.
%
% Return 
%    o - the offset for each axis (1x3 vector)
%    s - the sensitivity for each axis (1x3 vector)
%    r - the rail of the first sphere. Could be used to determine if need
%    extra samples.
%
% The calibration parameters should be used as:
%   accCalibrated = (accMeasured - o) / s
% 

%Filter test
% [b,a] = butter(2, 2/40);
% 
% accX = filtfilt(b,a,double(accX));
% accY = filtfilt(b,a,double(accY));
% accZ = filtfilt(b,a,double(accZ));

% Return to original byte scale
% accX = double(accX) / (2/512);
% accY = double(accY) / (2/512);
% accZ = double(accZ) / (2/512);

%Implementing equation 11
firstRow = ones(size(accX));

accSamples = [ firstRow; accX; accY; accZ ];
Asystem = accSamples * accSamples';

E = -(accX.^2 + accY.^2+ accZ.^2);

Bsystem = E * accSamples';

%resp contains A, B, C and D from equation 11
resp = mldivide(Asystem, Bsystem');

%calculate offset (o) from equation 7a-d
o = resp(2:4)/(-2);

r = sqrt(sum(o.^2) - resp(1));

%Equation 14a-c
accX = (accX - o(1)).^2;
accY = (accY - o(2)).^2;
accZ = (accZ - o(3)).^2;

%Calculate the sensitivity using equation 17

accSamples2 = [ accX; accY; accZ ];
Asystem2 = accSamples2 * accSamples2';

Bsystem2 = [sum(accX); sum(accY); sum(accZ)]';

%resp contains A, B, C and D from equation 11
resp2 = mldivide(Asystem2, Bsystem2');

s = 1./sqrt(resp2);



end

