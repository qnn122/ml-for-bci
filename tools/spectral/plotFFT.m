function plotFFT(sig, Fs, ha_fft)
%% PLOTFFT_SIMULATION visualizes simulated power spectrum in realtime. The 
% peak of each power spectrum at given time is detected and marked. The
% corresponding SNR value is also calculated.
% 
% In:
%   Sig     : the signal that needs analyzing
%   Fs      : sampling frequency
%   ha_fft  : axes handle for fft
%
% Example:
%   
% See also fft
%%
data = sig;
windowL = length(sig);

% Initializing
L = length(data);        % Length of the signal
T = 1/Fs;               % Sample time

% Set up parameters for Fourier transform
% Double number of FFT point by two time window Length, peak finding
% technique
NFFT = 2^nextpow2(windowL*2);           % Next power of 2 from length of y, required for fast fourier transform to perform at its best
f = Fs/2*linspace(0,1,NFFT/2+1);        % frequency series vector

% Initialize the plot
%figure('Name', 'Simulated Realtime FFT analyzing')
hplot = stem(ha_fft,f, f);             % Plot anything, doesnt matter
xlabel(ha_fft,'Frequency (Hz)'); ylabel(ha_fft,'|Y(f)|');

% Event marker plot
% timemarker = time_simulation(event, ha_event, Fs);

x = data;             % Fraction of signal being analyzed
y_temp = fft(x,NFFT)/windowL;       % Perform Fourier Transform
y = 2*abs(y_temp(1:NFFT/2+1));      % Take absolute values and only the first half of the result since the second is just a mirror of the first one.

% Segment the interested range of frequency (from 5 to 40Hz)
idx = find(f>=5 & f<=40);
interestY = y(idx); 
interestF = f(idx);

% Update plot's data
set(hplot, 'XData', interestF);
set(hplot, 'YData', interestY);

% Detect peak  
indexmax = find(max(interestY) == interestY); % Find index of peak y
xmax = interestF(indexmax);
ymax = interestY(indexmax);

% SNR
meanY = mean(interestY);

    

