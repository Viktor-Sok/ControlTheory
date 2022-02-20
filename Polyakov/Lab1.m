%% Create tf object
b2=1.8;
b1=-1.98;
b0=0.432;
a2=1.2000;
a1=0.7644;
a0=0.3556;
f = tf([ b2 b1 b0],[1 a2 a1 a0])
%% Different representations of dynamic system
zpkf = zpk(f) %zero/pole/gain
f_ss = ss(f) % state space model
%% Analysis of the model
k = dcgain(f)
z=zero(f)
p=pole(f)
b = bandwidth(f)
pzmap(f) % plot zeros and poles
%% Adding feedforward y = Cx + Du
f1_ss = f_ss;
f1_ss.d = 1 ;
f1 = tf(f1_ss)
pzmap(f1)
k1 = dcgain(f1) % k1 = k + 1 feedforward with gain 1 adds additional output
%% Using LTI Viewer
ltiview % allows to plot step, impulse response and other types of plots
%% Bode Plot
w = logspace(-1,2,100);
Lw = freqresp(f,w);
Lw = Lw(:); % converts 3D array to 1D for one-dimensional LTI systems
semilogx(w, abs(Lw))
%% Feed abitrary input  to the model
[u,t] = gensig('square',4); % generating rectangular sognal with period 4 sec
lsim(f,u,t) ; % feed signal u to  linear model and plot it