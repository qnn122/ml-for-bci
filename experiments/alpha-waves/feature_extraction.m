function  feature = feature_extraction(sig, params)
%FEATURE_EXTRACTION Summary of this function goes here
%   Detailed explanation goes here

% Handling input
% TODO: better input handling
if isfield(params, 'Fs') & ~isempty(params)
    Fs = params.Fs;
else
    warning('No Fs provided!');
end

if isfield(params, 'band') & ~isempty(params)
    band = params.band;
else
    warning('No bandwidth provided!');
end

% Calculate features
[f, y] = calc_fft(sig, Fs, band);
% feature = [f(y==max(y)), max(y)];  

% Another feature
ind = find(f >= 8 & f <= 13);
y = y(ind);
feature = [mean(y)/std(y), max(y)];

% Your customized features
% ----- ENTER YOUR CODE HERE -----------

end

