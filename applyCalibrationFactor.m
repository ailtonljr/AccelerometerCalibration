function [ calibAccX, calibAccY, calibAccZ ] = applyCalibrationFactor( accX, accY, accZ, o, s )
%applyCallibrationFactor Apply the calibration factor on the accelerometers
%signals.
%   This function applies the calibration factor on the accelerometers
%   signals to obtain the acceleration withou offset and with correct scale
%   factor.
%
% Inputs:
%   accX, accY, accZ - Vectors containing the acceleration (1xn vectors)
%   o, s - Calibration facctors (offset and scale). These parameters should
%   be obtained using calibrateAccelerometer function.
% Outputs:
%   calibAccX, calibAccY, calibAccZ - the acclerometer signal with removed
%   offset and correct scale.

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

calibAccX = (accX - o(1))/s(1);
calibAccY = (accY - o(2))/s(2);
calibAccZ = (accZ - o(3))/s(3);

end

