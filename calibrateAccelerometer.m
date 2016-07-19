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
%    each axis (1xn vector).
%
% Return 
%    o - the offset for each axis (1x3 vector)
%    s - the sensitivity for each axis (1x3 vector)
%    r - the radius of the first sphere. Could be used to determine if need
%    extra samples.
%
% The calibration parameters should be used as:
%   accCalibrated = (accMeasured - o) / s
% 

%     Copyright 2016 Ailton Luiz Dias Siqueira Junior.
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.

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

