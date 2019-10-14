%% Load data
close all; clear all;
addpath '../../data/ssvep/'
ALLEEG = load('run-2.mat').ALLEEG; % EEGLAB format
sig = ALLEEG.data(2,:);
plot(sig)

%% Load tool
addpath '../../tools/spectral'

%% Visualization
figure;
%start = 700;    % First few seconds of the recording is often artifacts.
start = 700;
subplot(2,1,1), plot(sig(start:end)); axis tight;
ax = subplot(2,1,2); plot_spectrogram(sig, start, 1, ax), colorbar('Off'); colormap(jet(256));
hold on
        
%% Visualize Events
events = ALLEEG.event;
Fs = ALLEEG.srate;          % sampling frequency
duration = Fs*10;            % duration of eacch event = 5 seconds
start = 1000;               % avoid artifacts and the beginning of the recordings

% Plot spectrogram 
figure;
hax = subplot(1,1,1);
plot_spectrogram(sig, start, 1, hax); colorbar('Off'); colormap(jet(256));

% Plot event onset over the 
events_sti1 = [];           % 6.6Hz
events_sti2 = [];           % 7.5Hz
events_sti3 = [];           % 8.25Hz
events_sti4 = [];           % 10Hz
events_rest = [];           % resting
numevent = length(events); 

% Colors for each events
color_sti1 = '#4DBEEE';
color_sti2 = '#77AC30';
color_sti3 = '#FF00FF';
color_sti4 = 'red';
color_rest = 'blue';
for i = 1:numevent
    event = events(i).latency;
    event_norm = (event - start)/Fs/60;     % offseted by start, normalized by Fs and minutes
    x = [event_norm, event_norm];
    y = [0, 35];
    if strcmp(events(i).type, 'Rest')
        line(hax, x,y, 'Color', color_rest, 'LineWidth', 2)
        events_rest = [events_rest, event]; % TODO:handling better variable 
    elseif strcmp(events(i).type, '6.6Hz')
        line(hax, x,y, 'Color', color_sti1, 'LineWidth', 2)
        events_sti1 = [events_sti1, event];
    elseif strcmp(events(i).type, '7.5Hz')
        line(hax, x,y, 'Color', color_sti2, 'LineWidth', 2)
        events_sti2 = [events_sti2, event];
    elseif strcmp(events(i).type, '8.75Hz')
        line(hax, x,y, 'Color', color_sti3 , 'LineWidth', 2) 
        events_sti3 = [events_sti3, event];
    elseif strcmp(events(i).type, '10Hz')
        line(hax, x,y, 'Color', color_sti4, 'LineWidth', 2)
        events_sti4 = [events_sti4, event];
    end
end

%% Feature extraction
n_samples = 1000;                    % for each class
n_features = 3;
window_sec = 1;
window = window_sec*Fs;             % window if spectral feature = 1 second
band = [5, 35];
params.Fs = Fs;
params.band = band;
params.duration = duration;
params.window = window;

% Class 1: close eyes (alpha waves)
feat_sti1 = zeros(n_samples, n_features); 
feat_sti2 = zeros(n_samples, n_features);
feat_sti3 = zeros(n_samples, n_features);
feat_sti4 = zeros(n_samples, n_features);
feat_rest = zeros(n_samples, n_features);

n_events_sti1 = length(events_sti1);
n_events_sti2 = length(events_sti2);
n_events_sti3 = length(events_sti3);
n_events_sti4 = length(events_sti4);
n_events_rest = length(events_rest);

% TODO: extract feature from different runs
disp('Extracting features...')
for i = 1:n_samples
    % Stimulus 1
    event_sti1_chosen = events_sti1(randi(n_events_sti1));
    feat = feature_extraction_of_event(sig, event_sti1_chosen, params);
    feat_sti1(i, :) = feat;
    
    % Stimulus 2
    event_sti2_chosen = events_sti2(randi(n_events_sti2));
    feat = feature_extraction_of_event(sig, event_sti2_chosen, params);
    feat_sti2(i, :) = feat;
    
    % Stimulus 3
    event_sti3_chosen = events_sti3(randi(n_events_sti3));
    feat = feature_extraction_of_event(sig, event_sti3_chosen, params);
    feat_sti3(i, :) = feat;
    
    % Stimulus 4
    event_sti4_chosen = events_sti4(randi(n_events_sti4));
    feat = feature_extraction_of_event(sig, event_sti4_chosen, params);
    feat_sti4(i, :) = feat;
    
    % Resting
    event_rest_chosen = events_rest(randi(n_events_rest));
    feat = feature_extraction_of_event(sig, event_rest_chosen, params);
    feat_rest(i, :) = feat;
end 

disp('Done')

%% Visualize features
figure('Color', 'white');
hax = axes('FontSize', 13);
hold on;
xaxis = 3;
yaxis = 2;
scatter(feat_sti1(:,xaxis), feat_sti1(:,yaxis), 50, 'MarkerFaceColor', color_sti1, 'MarkerEdgeColor', 'white')
scatter(feat_sti2(:,xaxis), feat_sti2(:,yaxis), 50, 'MarkerFaceColor', color_sti2, 'MarkerEdgeColor', 'white')
scatter(feat_sti3(:,xaxis), feat_sti3(:,yaxis), 50, 'MarkerFaceColor', color_sti3, 'MarkerEdgeColor', 'white')
scatter(feat_sti4(:,xaxis), feat_sti4(:,yaxis), 50, 'MarkerFaceColor', color_sti4, 'MarkerEdgeColor', 'white')

scatter(feat_rest(:,xaxis), feat_rest(:,yaxis), 50, 'MarkerFaceColor', color_rest)
legend('6.6Hz', '7.5Hz', '8.75Hz', '10Hz', 'Rest')
ylabel('Max(spectral)');
xlabel('Frequency at max(spectral)');
hold off;

%% Visualize in 3D (if any)
figure;
hold on;
scatter3(feat_sti1(:,1), feat_sti1(:,2), feat_sti1(:,3), 50, 'MarkerFaceColor', color_sti1, 'MarkerEdgeColor', 'white')
scatter3(feat_sti2(:,1), feat_sti2(:,2), feat_sti2(:,3), 50, 'MarkerFaceColor', color_sti2, 'MarkerEdgeColor', 'white')
scatter3(feat_sti3(:,1), feat_sti3(:,2), feat_sti3(:,3), 50, 'MarkerFaceColor', color_sti3, 'MarkerEdgeColor', 'white')
scatter3(feat_sti4(:,1), feat_sti4(:,2), feat_sti4(:,3), 50, 'MarkerFaceColor', color_sti4, 'MarkerEdgeColor', 'white')

scatter3(feat_rest(:,1), feat_rest(:,2), feat_rest(:,3), 50, 'MarkerFaceColor', color_rest)
legend('6.6Hz', '7.5Hz', '8.75Hz', '10Hz', 'Rest')
ylabel('Max(spectral)');
xlabel('SNR');
zlabel('Frequency at max(spectral)');
hold off;