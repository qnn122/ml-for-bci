%% Constants
Fs = 250;
savefilename = 'run-5';

%% Load data
addpath '../../data/ssvep'
allsig = load(strcat(savefilename, '-raw.mat')); % EEGLAB format

% TODO: consider convert necessary data to ALLEEG, remove raw files. Keep
% the raw signals

% Select filtered channel
chan1 = allsig.data1ftft;
chan2 = allsig.data2ftft;

ALLEEG.data = cat(1, chan1, chan2);
ALLEEG.srate = Fs;

%%
n_event = 16;
clearvars event;

event(1).latency = 45*Fs;
event(1).type = '6.6Hz';

event(3).latency = event(1).latency + 20*Fs;
event(3).type = '6.6Hz';

event(5).latency = event(3).latency + 20*Fs;
event(5).type = '7.5Hz';

event(7).latency = event(5).latency + 20*Fs;
event(7).type = '7.5Hz';

event(9).latency = event(7).latency + 20*Fs;
event(9).type = '8.75Hz';

event(11).latency = event(9).latency + 20*Fs;
event(11).type = '8.75Hz';

event(13).latency = event(11).latency + 20*Fs;
event(13).type = '10Hz';

event(15).latency = event(13).latency + 20*Fs;
event(15).type = '10Hz';

for i = 1:n_event
    if mod(i,2) == 0
        event(i).latency = event(i-1).latency + 10*Fs;
        event(i).type = 'Rest';
    end
end

%%
ALLEEG.event = event;

%% Saving data
save(strcat(savefilename, '.mat'), 'ALLEEG');