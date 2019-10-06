%% Load data
addpath '../../data/ssvep'
allsig = load('run-2.mat'); % EEGLAB format
sig = allsig.data2ftft;
plot(sig)

%% Load tool
addpath '../../tools/spectral'

%% Visualization
figure;
start = 700;    % First few seconds of the recording is often artifacts.
subplot(2,1,1), plot(sig(start:end))
ax = subplot(2,1,2); plot_spectrogram(sig, start, 1, ax), colorbar('Off');
