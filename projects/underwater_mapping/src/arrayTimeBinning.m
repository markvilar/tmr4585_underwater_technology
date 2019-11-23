function binned = arrayTimeBinning(timeRefs, arr, timePad)
% Performs binning of data according to the time stamps in two tables.
% The function assumes that the time stamps are in the first column of 
% their respective tables and that.
% arg timeRefs: array, reference timestamps
% arg arr: array, data to be binned
% return binned: cell array of arrays, binned data
if nargin < 3
    timePad = 1;
end

timeRefs = timeRefs(:); % Make column

times = arr(:,1);
timeRefsLow = [timeRefs(1)-timePad; timeRefs(2:end)];
timeRefsHigh = [timeRefs(2:end); timeRefs(end)+timePad];

nRefs = length(timeRefs);
nSamples = size(arr, 1);
binned = cell(nRefs, 1);

for i = 1:nSamples
    time = times(i);
    isInBin = (timeRefsLow <= time).*(time < timeRefsHigh);
    ind = find(isInBin, 1);
    if ~isempty(ind) % If the sample is within a given time bin
        binned{ind} = [binned{ind}; arr(i, 2:end)];
    end
end