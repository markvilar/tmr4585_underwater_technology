clear all; clc;

%% Figures
figuresFolder = '../figures';

%% Read data
dataFolder = '../results';
dataFile = 'CTD_harald_corrected.csv';
dataPath = strcat(dataFolder, '/', dataFile);
opts = detectImportOptions(dataPath);
tableHead = preview(dataPath, opts);
opts.SelectedVariableNames = [1, 5, 6, 8, 10:12];
data = readmatrix(dataPath, opts);

%% Plot data
time = data(:,1);
latitude = data(:,2);
longitude = data(:,3);
depth = data(:,4);
conductivity = data(:,5);
temperature = data(:,6);
salinity = data(:,7);

%% Data binning
incDepth = 1;
N = length(depth);
maxDepth = ceil(max(depth));
minDepth = floor(min(depth));
maxDepthModInc = mod(maxDepth, incDepth);
minDepthModInc = mod(minDepth, incDepth);

if maxDepthModInc ~= 0
    maxDepth = maxDepth + (incDepth - maxDepthModInc);
end

if minDepthModInc ~= 0
    minDepth = minDepth - minDepthModInc;
end

% Create bins
nBins = (maxDepth - minDepth) / incDepth;
bins = [minDepth:incDepth:(maxDepth-incDepth); 
    (minDepth+incDepth):incDepth:maxDepth];

% Bin data
binnedData = cell(3, nBins);
for i = 1:N
    s = salinity(i);
    c = conductivity(i);
    t = temperature(i);
    d = depth(i);
    isInBin = (bins(1,:) <= d).*(d < bins(2,:));
    ind = find(isInBin, 1);
    binnedData{1, ind} = [binnedData{1, ind}, s];
    binnedData{2, ind} = [binnedData{2, ind}, c];
    binnedData{3, ind} = [binnedData{3, ind}, t];
end

% Process binned data
binDepths = zeros(1, nBins);
saliMeans = zeros(1, nBins);
saliStds = zeros(1, nBins);
condMeans = zeros(1, nBins);
condStds = zeros(1, nBins);
tempMeans = zeros(1, nBins);
tempStds = zeros(1, nBins);

for i = 1:nBins
    d = minDepth + i*incDepth;
    ss = binnedData{1, i};
    cs = binnedData{2, i};
    ts = binnedData{3, i};
    binDepths(i) = d;
    saliMeans(i) = mean(ss);
    saliStds(i) = std(ss);
    condMeans(i) = mean(cs);
    condStds(i) = std(cs);
    tempMeans(i) = mean(ts);
    tempStds(i) = std(ts);
end

%% Profile plots
% Salinity
figure(1); clf;
hold on; grid on;
plot(saliMeans, binDepths, 'b');
plot(saliMeans-saliStds, binDepths, 'r--');
plot(saliMeans+saliStds, binDepths, 'r--');
set(gca, 'YDir','reverse'); % Flip y-axis
legend('\mu_{s}', '\mu_{s} \pm \sigma_{s}', 'Location', 'west')
xlabel('Salinity [g/kg]');
ylabel('Depth [m]');
title(sprintf('Salinity vs. depth (depth binning of %.1f m)', ...
    incDepth));

% Conductivity
figure(2); clf;
hold on; grid on;
plot(condMeans, binDepths, 'b');
plot(condMeans-condStds, binDepths, 'r--');
plot(condMeans+condStds, binDepths, 'r--');
set(gca, 'YDir','reverse'); % Flip y-axis
legend('\mu_{c}', '\mu_{c} \pm \sigma_{c}', 'Location', 'west')
xlabel('Conductivity [S/m]');
ylabel('Depth [m]');
title(sprintf('Conductivity vs. depth (depth binning of %.1f m)', ...
    incDepth));

% Temperature
figure(3); clf;
hold on; grid on;
plot(tempMeans, binDepths, 'b');
plot(tempMeans-tempStds, binDepths, 'r--');
plot(tempMeans+tempStds, binDepths, 'r--');
set(gca, 'YDir','reverse'); % Flip y-axis
legend('\mu_{t}', '\mu_{t} \pm \sigma_{t}', 'Location', 'west')
xlabel(['Temperature [' char(176) 'C]']);
ylabel('Depth [m]');
title(sprintf('Temperature vs. depth (depth binning of %.1f m)', ...
    incDepth));

%% Trajectory plot
% Colors
circleSize = 1;
colors = repmat([1, 2, 3], numel(time), 1);

% Scatter plot
figure(10); clf;
scatter3(latitude, longitude, depth, circleSize);