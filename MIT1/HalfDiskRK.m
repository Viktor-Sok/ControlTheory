function [ t, theta] = HalfDiskRK( theta0, T )
%   t : (Nx1)
%   theta : (Nx1) 
%   theta0: (1x2) - initial angle and angular speed 
%   T - simulation time
r = 1;
a = 4*r/(3*pi);
g = 9.81;
mass = @(t,y) [[1,0];[0,3/2-2*a*cos(y(1))]];
options = odeset('RelTol', 1e-5, 'AbsTol', [1e-7,1e-7], 'Mass', mass);
right_side = @(t,y) [y(2);-a*sin(y(1)).*(2*y(2).^2+g)];
[t,theta] = ode45(right_side, [0,T], theta0, options);
end

