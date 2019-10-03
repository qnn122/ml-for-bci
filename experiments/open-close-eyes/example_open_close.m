%% Load data
addpath '../../data/test alpha 5s'
ALLEEG = load('5sopen_close.mat').ALLEEG; % EEGLAB format
sig = ALLEEG.data;
plot(sig)

%% Load tool
addpath '../../tools/spectral'
help plot_spectrogram   % Take a look at input requirments of the plot_spectrogram function

%% Visualization
figure;
start = 700;    % First few seconds of the recording is often artifacts.
subplot(2,1,1), plot(sig(start:end))
ax = subplot(2,1,2); plot_spectrogram(sig, start, 1, ax), colorbar('Off');

%% Examination
event = ALLEEG.event;
event1 = event(5).latency; % odd: closed, even: open
window = ALLEEG.srate*5;

closed_sample = sig(event1:(event1+window));
open_sample = sig((event1-window):event1);
figure;
subplot(2,1,1), plot(closed_sample), title('closed')
subplot(2,1,2), plot(open_sample), title('open')

plot_FFT(closed_sample, 250);