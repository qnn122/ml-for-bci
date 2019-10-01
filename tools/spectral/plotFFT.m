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

data = sig;
windowL = length(sig);

% Initializing
L = length(data);        % Length of the signal
T = 1/Fs;               % Sample time
ts = (0:L-1)*T;          % Time vector


% Set up parameters for Fourier transform
% Double number of FFT point by two time window Length, peak finding
% technique
NFFT = 2^nextpow2(windowL*2);           % Next power of 2 from length of y, required for fast fourier transform to perform at its best
f = Fs/2*linspace(0,1,NFFT/2+1);% frequency series vector

% Initialize the plot
%figure('Name', 'Simulated Realtime FFT analyzing')
hplot = stem(ha_fft,f, f);             % Plot anything, doesnt matter
htext = text(0,0, 'Nothing', 'HorizontalAlignment', 'left','Parent',ha_fft);   % Init a text for peak
htitle = title(ha_fft,'Simulated Real Time Power Spectrum');
xlabel(ha_fft,'Frequency (Hz)'); ylabel(ha_fft,'|Y(f)|');

% Event marker plot
% timemarker = time_simulation(event, ha_event, Fs);

