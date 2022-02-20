function [t, theta] = HalfDiskAN( theta0, T )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
r = 1;
a = 4*r/(3*pi);
g = 9.81;
omega = sqrt( a*g/(3/2-2*a) );
t = 0:0.1:T;
theta = theta0(1)* cos(omega*t) + theta0(2)/omega*sin(omega*t);
end

