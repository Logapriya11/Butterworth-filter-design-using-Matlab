clc
close all
delta1 = 0.01;
delta2 = 0.005;
Rp = -20*log10(1-delta1);
Rs = -20*log10(delta2);
Omegap = 0.2*pi;
Omegas = 0.3*pi;

%find the order and natural frequency
[N,Omegan] = buttord(Omegap/pi,Omegas/pi,Rp,Rs);
% find coefficients 
[b,a] = butter(N,Omegan);

[H,Omega] = freqz(b,a,2048);
figure(1)
subplot(2,1,1)
plot (Omega/pi,abs(H));
xlabel( 'Frequency (\Omega/\pi)'), ylabel('|H(e^{j\Omega})|')
ylim([-0.1 1.2])
xlim([0 1])
title("Butterworth IIR Filter")

subplot (2,1,2)
plot(Omega/pi,20*log10(abs(H)));
xlabel('Frequency (\Omega/\pi)'),ylabel('|H(e^{j\Omega})| (dB)')
ylim([-85 5])
xlim([0 1])

%zoom in to confirm specification met
figure(2)
subplot(2,1,1)
plot(Omega/pi,abs(H));
xlabel( 'Frequency (\Omega/\pi)'), ylabel('|H(e^{j\Omega})|')
title("Butterworth IIR Filter Passband")
% Limit plot to cover passband region
xlim([0 Omegap/pi])
ylim( [1-0.01 1+0.01]);

subplot(2,1,2)
plot(Omega/pi,abs(H));
xlabel('Frequency (\Omega/\pi)'), ylabel('|H(e^{j\Omega})|')
title("Butterworth IIR Filter Stopband")
% Limit plot to cover stopband region
xlim( [Omegas/pi 1])
ylim([0 0.005]);

figure(3)
%pzplot(b,a)
axis square
xlabel('Real'); ylabel('Imag');
title('Poles and Zeros of Butterworth Filter')
