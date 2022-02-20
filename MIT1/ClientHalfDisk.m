% Rolling Half-Disk, Linearized vs Exact equation
rad = pi/180;
[t, theta] = HalfDiskRK([5*rad,0],10);
[t1,theta1] = HalfDiskAN([5*rad,0],10);
plot(t,theta(:,1),'-')
hold on
plot(t1, theta1,'o')
hold off
figure
[t, theta] = HalfDiskRK([30*rad,0],10);
[t1,theta1] = HalfDiskAN([30*rad,0],10);
plot(t,theta(:,1),'-')
hold on
plot(t1, theta1,'o')
hold off
