function feature = feature_extraction_of_event(sig, event_chosen, params)
%FEATURE_EXTRACTION_OF_EVENT Summary of this function goes here
%   Extracting feature from a signal given a certain portion of the signal
%   defined in `event_chosen`.
%
% In:
%   sig <1xn> : signal of n points
%   range_chosen: chosen range in the signal to be feature-extracted
%   params <struct>:parameters of the extractor, in this case:
%                   Fs: sampling frequency
%                   band: frequency band of interests
%                   duration: duration of the events
%                   window: window of extractor
% Out:
%   feature: features of the signal
%
% See more: feature_extraction.m
%
% TODO: need more clear description of `duration` and `window`
% TODO: considering merging with feature_extraction.m

% Handling input
% TODO: better input handling: default values, handle more cases
if isfield(params, 'Fs') & ~isempty(params)
    Fs = params.Fs;
else
    warning('No Fs provided!');
end

if isfield(params, 'band') & ~isempty(params)
    band = params.band;
else
    warning('No frequency band provided!');
end

if isfield(params, 'duration') & ~isempty(params)
    duration = params.duration;
else
    warning('No frequency duration provided!');
end

if isfield(params, 'duration') & ~isempty(params)
    window = params.window;
else
    warning('No frequency duration provided!');
end

% select feature
feat_range = event_chosen:(event_chosen + duration - window);

% select starting point and the corresponding window
feat_start = feat_range(randi(numel(feat_range)));
feat_window = sig(feat_start:(feat_start + window - 1));

% feature extraction    
feature = feature_extraction(feat_window, params);

end

