function  [f ,y] = calc_fft(sig, Fs, bandwidth)
%CALC_FFT Calculate FFT of a signal
% 
% In:
%   sig     : the signal that needs analyzing
%   Fs      : sampling frequency
%   bandwidth: 1x2 vector, lower and higher value of the selected band
%   width
%
% Example:
%   [f, y] = calc_fft(sig, 250, [5, 40])
%   stem(f,y)
%

windowL = length(sig);

% Set up parameters for Fourier transform
% Double number of FFT point by two time window Length, peak finding technique
NFFT = 2^nextpow2(windowL*2);       % Next power of 2 from length of y, required for fast fourier transform to perform at its best
F = Fs/2*linspace(0,1,NFFT/2+1);    % frequency series vector

% Perform fft
x = sig;             % Fraction of signal being analyzed
y_temp = fft(x,NFFT)/windowL;       % Perform Fourier Transform
Y = 2*abs(y_temp(1:NFFT/2+1));      % Take absolute values and only the first half of the result since the second is just a mirror of the first one.


% Segment the interested range of frequency (from 5 to 40Hz)
low = bandwidth(1);
hig = bandwidth(2);

idx = find(F >= low & F <= hig);
y = Y(idx); 
f = F(idx);
end

