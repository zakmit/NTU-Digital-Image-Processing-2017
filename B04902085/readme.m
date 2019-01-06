% DIP Homework Assignment #1
% Mar. 27, 2018
% Name: Ho Kai Chih
% ID #: B04902085
% email: b04902085@ntu.edu.tw
%###############################################################################%
% Warn-Up
% Implementation: Warm Up
% M-file name: warmup.m
% Usage: warmup
% Output image: B.raw
% Parameters: none
% Other parameters here
%###############################################################################%
disp('Please put input files into "raw" folder'); %display some useful information
disp('Running "warmup"...'); %display some useful information
warmup; % invoke your M-file properly!
disp('Done, "warmup", output image is "B.raw"');
%###############################################################################%
% Problem 1: Image Enhancement
% Implementation 1: Image Enhancement
% M-file name: Q1.m
% Usage: Q1
% Output image: D.raw, H.raw, L3.raw, L9.raw, LT.raw, ILT.raw, PT.raw
% Parameters: none
% Other parameters here
%###############################################################################%
disp('Running "Q1"...'); %display some useful information
Q1; % invoke your M-file properly!
disp('Done, "Q1", output image is "D.raw " for D, "H.raw" for H, "L3.raw" for 3x3 Local Histogram.');
disp('output image is "L9.raw " for 9x9 Local Histogram, "LT.raw" for Log Tranform, "ILT.raw" for Inverse Log Transform, "PT.raw" for Power-raw Transform.');
%###############################################################################%
% Problem 2: Noise Removal
% Implementation 2: Noise Removal
% M-file name: Q2.m
% Usage: Q2
% Output image: GauP1.raw, GauP2.raw, SaltP1.raw, SaltP2.raw, RG2_odd.raw,
% RS.raw, Result2_5.raw, Result2_5+13.raw, Result2.raw,
% Result2_5+13+5+13.raw, Result2_5+13+5+13+5.raw
% Parameters: none
% Other parameters here
%###############################################################################%
disp('Running "Q2"...'); %display some useful information
Q2; % invoke your M-file properly!
disp('Done, "Q2", output image is "GauP1.raw " for First Gaussian Noise, "GauP2.raw " for Second Gaussian Noise, "SaltP1.raw" for First Salt&Pepper Noise.');
disp('output image is "SaltP2.raw" for Second Salt&Pepper Noise, "RG2_odd.raw" for Gaussian Noise Removal, "RS.raw" for First Salt&Pepper Noise Removal.');
disp('output image is "Result2_5.raw" for Part2 wrinkle Removal First stage, "Result2_5+13.raw" for Part2 wrinkle Removal Second stage, "Result2_5+13+5.raw" for Part2 wrinkle Removal Third stage.');
disp('output image is "Result2_5+13+5+13.raw" for Part2 wrinkle Removal Third stage, "Result2.raw" for Part2 wrinkle Removal Final stage.');
%###############################################################################%