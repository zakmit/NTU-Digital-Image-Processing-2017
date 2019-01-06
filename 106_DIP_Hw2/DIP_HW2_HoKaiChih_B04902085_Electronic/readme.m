% DIP Homework Assignment #2
% Apr. 10, 2018
% Name: Ho Kai Chih
% ID #: B04902085
% email: b04902085@ntu.edu.tw
%###############################################################################%
% Problem 1: Edge Detection
% Implementation 1: Edge Detection
% M-file name: Q1.m
% Usage: Q1
% Output image: P3_40.raw, P4_40.raw, P9P_40.raw, P9S_40.raw,
% LIR_13_N_re.raw, LIR_13_S_re.raw, LOG_8_S_re.raw, Canny1.raw, Canny2.raw
% Parameters: none
% Other parameters here
%###############################################################################%
disp('Please put input files into "raw" folder'); %display some useful information
disp('Running "Q1"...'); %display some useful information
Q1; % invoke your M-file properly!
disp('Done, "Q1", 1st order output images are "P3_40.raw " for 3 points, "P4_40.raw" for 4 points, "P9P_40.raw" for 9 points Prewitt Mask, "P9S_40.raw" for 9 points Sobel Mask.');
disp('2nd order output images are "LIR_13_N_re.raw " for Laplacian impulse response non-separable, "LIR_13_S_re.raw " for Laplacian impulse response separable, "ILT.raw" for Inverse Log Transform, "LOG_8_S_re.raw" for Laplacian of Gaussian.');
disp('Canny Edge Detector output images are "Canny1.raw " for 1(a), "Canny2.raw " for 1(b).');

%###############################################################################%
% Problem 2: GEOMETRICAL MODIFICATION
% Implementation 2: GEOMETRICAL MODIFICATION
% M-file name: Q2.m
% Usage: Q2
% Output image: HPF_result.raw, C_US.raw, D.raw
% Parameters: none
% Other parameters here
%###############################################################################%
disp('Running "Q2"...'); %display some useful information
Q2; % invoke your M-file properly!
disp('Done, "Q2", output image is "HPF_result.raw " for High pass filtering in (a), "C_US.raw " for Unsharp Masking in (a), "D.raw" for 2(b).');
%###############################################################################%
% Bonus
% M-file name: Bonus.m
% Usage: Bonus
% Output image(Bonus1): Bonus1_Canny.raw, Close2.raw, Bonus1_F.raw, Bonus1_H.raw
% Output image(Bonus2): Bonus2_Canny.raw, Close2_2.raw, Bonus2_F.raw, Bonus2_H.raw
% Parameters: none
% Other parameters here
%###############################################################################%
disp('Running "Bonus"...'); %display some useful information
Bonus; % invoke your M-file properly!
disp('Done, "Bonus", Picture1 output images are "Bonus1_Canny.raw " for Canny Edge Detection Result, "Close2.raw " for twice Morphologic close on Canny Edge, "Bonus1_F.raw" is the result of applying threshold, "Bonus1_H.raw" is the Final result of applying Global Histogram.');
disp('Done, "Bonus", Picture2 output images are "Bonus2_Canny.raw " for Canny Edge Detection Result, "Close2_2.raw " for twice Morphologic close on Canny Edge, "Bonus2_F.raw" is the result of applying threshold, "Bonus2_H.raw" is the Final result of applying Global Histogram.');
%###############################################################################%