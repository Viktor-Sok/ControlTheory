%% Load
clear all;
clc;
%% Constants
T = 1; % sampling rate
Kc = 0.7045;
Ts = 18.2;
%% Digital Filter
Cpd = tf(Kc*[Ts+1 1], [1 1]); % continous transfer function
Dpd = c2d ( Cpd, T, 'tustin' ); % convert to descrete using Tustin(trapezoid integration)
[nD,dD] = tfdata ( Dpd, 'v' ); % numenator and denominator of discrete transfer function Dpd
%% Load Simulink Model
sim('Lab7_Digital') % load simulink model