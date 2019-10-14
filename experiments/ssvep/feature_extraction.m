function  feature = feature_extraction(sig, params)
%FEATURE_EXTRACTION Summary of this function goes here
%   Extracting feature from a signal
%
% In:
%   sig <1xn> : signal of n points
%   params <struct>:parameters of the extractor, in this case:
%                   Fs: sampling frequency
%                   band: frequency band of interests
%

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
    warning('No frequency band provided!');
end

% Frequency domail
[f, y] = calc_fft(sig, Fs, band);

% Calculate features
% feature = [f(y==max(y)), max(y)];  

% Another feature
%ind = find(f >= 9.5 & f <= 20);
%y = y(ind);
% feature = [mean(y)/std(y), max(y)];

% High-dimentional feature space
feature = [mean(y)/std(y), max(y), f(y==max(y))];

% Your customized features
% ----- ENTER YOUR CODE HERE -----------

end

