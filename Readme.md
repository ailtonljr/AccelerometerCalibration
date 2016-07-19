# Matlab Accelerometer calibration functions

Matlab functions to calculate the accelerometers calibration parameters from
tilt data using the method described in using the method
described by Gietzelt, M., Wolf, K. H., Marschollek, M., & Haux, R. (2013).
Performance comparison of accelerometer calibration algorithms based
on 3D-ellipsoid fitting methods. Computer Methods and Programs in
Biomedicine, 111(1), 62-71. http://doi.org/10.1016/j.cmpb.2013.03.006

For an usage example see [this page](html/calibrationExample.html).

      


  </style></head><body><div class="content"><h1>Example of accelerometer calibration and test with data</h1><!--introduction--><p>This shows an example of accelerometer calibration using the method described by Gietzelt, M., Wolf, K. H., Marschollek, M., &amp; Haux, R. (2013). Performance comparison of accelerometer calibration algorithms based on 3D-ellipsoid fitting methods. Computer Methods and Programs in Biomedicine, 111(1), 62-71. <a href="http://doi.org/10.1016/j.cmpb.2013.03.006">http://doi.org/10.1016/j.cmpb.2013.03.006</a></p><!--/introduction--><h2>Contents</h2><div><ul><li><a href="#1">Loading and view the calibration data</a></li><li><a href="#2">Calculate the accelerometer calibration parameters</a></li><li><a href="#3">Loading a test accelerometer signal</a></li><li><a href="#4">Calculate the norm of the acceleration before the calibration</a></li><li><a href="#5">Applying the calibration factors</a></li><li><a href="#6">Calculate the norm after the calibration</a></li><li><a href="#7">Copyright 2016 Ailton Luiz Dias Siqueira Junior.</a></li></ul></div><h2>Loading and view the calibration data<a name="1"></a></h2><pre class="codeinput"><span class="comment">%Load the calibration data. This was recorded making slow movements in the</span>
<span class="comment">%accelerometer in such way the gravity vector forms a sphere.</span>

load <span class="string">calib_acc_01.mat</span>

accXcalib = double(Respiratory_Sensor_Port_COM3_Canal_0_g_Amplitude);
accYcalib = double(Respiratory_Sensor_Port_COM3_Canal_1_g_Amplitude);
accZcalib = double(Respiratory_Sensor_Port_COM3_Canal_2_g_Amplitude);

<span class="comment">%Plot the data so you can see the movement made.</span>

plot3(accXcalib, accYcalib, accZcalib);
</pre><img vspace="5" hspace="5" src="html/calibrationExample_01.png" alt=""> <h2>Calculate the accelerometer calibration parameters<a name="2"></a></h2><pre class="codeinput">[ offset, scale, radius ] = calibrateAccelerometer(accXcalib, accYcalib, accZcalib)
</pre><pre class="codeoutput">
offset =

    0.0593
    0.0744
    0.0280


scale =

    1.0211
    1.0291
    0.9866


radius =

    1.0094

</pre><h2>Loading a test accelerometer signal<a name="3"></a></h2><pre class="codeinput"><span class="comment">%Load the test signal. This signal contains the accelerometer fixed in 12</span>
<span class="comment">%different positions.</span>

<span class="comment">%Concatenate the data</span>
accX = [];
accY = [];
accZ = [];

<span class="keyword">for</span> n=1:12

    load([<span class="string">'fix_acc_01_'</span> num2str(n) <span class="string">'.mat'</span>])

    eval([<span class="string">'accX = [accX Respiratory_Sensor_Port_COM3_Canal_0_g_Amplitude];'</span>]);
    eval([<span class="string">'accY = [accY Respiratory_Sensor_Port_COM3_Canal_1_g_Amplitude];'</span>]);
    eval([<span class="string">'accZ = [accZ Respiratory_Sensor_Port_COM3_Canal_2_g_Amplitude];'</span>]);

<span class="keyword">end</span>

<span class="comment">%Plot the data so you can see the test points on the sphere.</span>

plot3(accX, accY, accZ, <span class="string">'x'</span>);
</pre><img vspace="5" hspace="5" src="html/calibrationExample_02.png" alt=""> <h2>Calculate the norm of the acceleration before the calibration<a name="4"></a></h2><pre class="codeinput"><span class="comment">%Norm of the acceleration before the calibration</span>
modBeforeCalibration = sqrt(accX.^2 + accY.^2 + accZ.^2);

<span class="comment">%The histogram of the norm before the calibration.</span>
hist(modBeforeCalibration,20);
title([<span class="string">'Before calibration'</span>]);
xlim([0.8 1.2]);
</pre><img vspace="5" hspace="5" src="html/calibrationExample_03.png" alt=""> <h2>Applying the calibration factors<a name="5"></a></h2><pre class="codeinput"><span class="comment">%Apply the calibration factors</span>
[ calibAccX, calibAccY, calibAccZ ] = applyCalibrationFactor( accX, accY, accZ, offset, scale );
</pre><h2>Calculate the norm after the calibration<a name="6"></a></h2><pre class="codeinput">modAfterCalibration = sqrt(calibAccX.^2 + calibAccY.^2 + calibAccZ.^2);

<span class="comment">%Comparing the histogram before and after the calibration.</span>
subplot(2, 1, 1);
hist(modBeforeCalibration,20);
title([<span class="string">'Before calibration'</span>]);
xlim([0.8 1.2]);
xlabel(<span class="string">'Acceleration (g)'</span>);
subplot(2, 1, 2);
hist(modAfterCalibration,20);
title(<span class="string">'After calibration'</span>);
xlim([0.8 1.2]);
xlabel(<span class="string">'Acceleration (g)'</span>);
</pre><img vspace="5" hspace="5" src="html/calibrationExample_04.png" alt=""> <h2>Copyright 2016 Ailton Luiz Dias Siqueira Junior.<a name="7"></a></h2><p>This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.</p><p>This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.</p><p>You should have received a copy of the GNU General Public License along with this program.  If not, see <a href="http://www.gnu.org/licenses/">http://www.gnu.org/licenses/</a>.</p>
