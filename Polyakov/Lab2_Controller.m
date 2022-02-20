 %% Entering transfer function
 Ts = 17.0;
 K = 0.07;
 Tr = 2;
 Tos = 6;
 P = tf(K, [Ts 1 0]);
 R0 = tf(1, [Tr 0]);
 R = feedback(R0,1); % unit negative feedback
 G = P*R % actuator + plant
 step(G) % step response actuator input - plant output
 tf_sensor = tf(1, [Tos 1]);
 open_loop = G*tf_sensor
 %% Open loop analysis
 bode(open_loop)
 %% Designing a compensator in sisotool
 % It's possible to see Bode plots of closed and open loop systems; and
 % atep reponse at the same time, tweaking the controller
 sisotool %single input single output tool
 %% PD-controller
 Tv = 1;
 PD  = 1 + tf([Ts 0],[Tv 1]);
 %% Closed loop system (use PD_controller designed in sisotool)
 W = feedback(PDsisotool*G, tf_sensor)
 W = minreal(W)
 %% Transfer function input - controller outputinreal(C/ (1 + C*G*H))
 Wu = minreal(PDsisotool/ (1 + PDsisotool*G*tf_sensor))
 step(Wu)