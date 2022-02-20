%% Creating Linear System 
F = tf(1, [1,1]);
%% Theoretical values of random process
sigmau = norm(F) % K(0) = sqrt(D{u}) of the output of LTI if input is white noise
Du = sigmau^2
bw = bandwidth(F)
tau = 2*pi/100/bw %correlation time of approximate white noise correlation function modeled as uniform random values with tau time gap
%% Export from simulink reults of simulation with sample time tau - variable LinearSystemOutput
%% Results of the simulation of random process(white noise)
t = LinearSystemOutput(:,1);
u = LinearSystemOutput(:,2);
std(u)
var(u)
error = (std(u)-sigmau)/sigmau*100
%% Auto-Correlation Theory vs Simulation
R = xcorr(u)/length(u); % divided by length(u) to plot unbiesed(actual) correlation function
Rplus = R(floor(length(R)/2):end); % select correlation function with positive tau (it's symmetric K(-tau) = K(tau))
M = 200; % M << len(t) to estimate correlation function
t1 = t(1:M); Rplus1 = Rplus(1:M);
R_teor = 0.5*exp(-abs(t1)); % theoretical correlation function for LTI with 1/(1+s)transfer function
hamm = 0.54 + 0.46*cos(pi*t1/max(t1)); % Hamming window
Rhamm = Rplus1 .* hamm; 
figure(1);
plot(t1, Rplus1, t1, R_teor,t1, Rhamm)
xlim([0 max(t1)]); % limits for x axis
%% Spectral dencity S as Fourier transform of correlation function R
w = 0:0.02:5;
Sw = []; Sw_teor =[];% simulational and theoretical spectral densities
Swhamm = []; % spectral dencity colculated using smoothed correlation function by Hamming window
for i=1:length(w)
 Sw(i) = sum(Rplus1 .* cos(w(i)*t1));
 Sw_teor(i) = 1 / (w(i)*w(i) + 1);
 Swhamm(i) = sum(Rhamm .* cos(w(i)*t1));
end;    
Sw = 2*tau*Sw;
Swhamm = 2*tau*Swhamm;
figure(2);
plot ( w, Sw, w, Sw_teor, w, Swhamm );
%% Variance through Spectral Density 
trapz(w,Sw)/pi
trapz(w,Sw_teor)/pi
%% Spectral Density using DFT (FFT algorithm)
N = 2*pi/0.5/tau; % choosing N (Nyquist theorem )
N = 2^nextpow2(N); % nearest pover of two for FFT algorythm
Fw = tau * fft(u, N); % FFT
Sw_fft = Fw .* conj(Fw) / N / tau; % spectral density
Sw_fft = Sw_fft(1:N/2+1); % first part of the spectum(up to Nyquist frequency)
w1 = 2*pi*[0:N/2] / N / tau; %  frequencies
%With Hamming window
scale = 1/sqrt(0.54^2 + 0.46^2/2); % coefficient to keep eqaual total energy (area under S(w)) with and without Hamming window
hamm = hamming(N) * scale;
uHamm = u(1:N) .* hamm;
Fw1 = tau* fft(uHamm, N); % FFT
Sw_fftHamm = Fw1 .* conj(Fw1) / N / tau;
Sw_fftHamm = Sw_fftHamm(1:N/2+1); 
figure(3)
plot ( w, Sw_teor, w1, Sw_fft, w1, Sw_fftHamm  );
xlim([0 max(w)]);



