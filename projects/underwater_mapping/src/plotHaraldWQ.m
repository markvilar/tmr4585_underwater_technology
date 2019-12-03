clear all; clc;

%% Figures
figuresFolder = '../figures';

%% Read data
dataFolder = '../results';
dataFile = 'water_quality_harald_corrected.csv';
dataPath = strcat(dataFolder, '/', dataFile);
opts = detectImportOptions(dataPath);
tableHead = preview(dataPath, opts);
data = readmatrix(dataPath, opts);

%% Variables
latitude = data(:, 2);
longitude = data(:, 3);
depth = data(:, 4);
chlorophyll = data(:, 6);
cDom = data(:, 7);
oxygen = data(:, 8);

%% Plot
X = oxygen;
C = repmat([1,2,3],numel(X),1);

%circleSize = 6;
%figure(1); clf;
%scatter3(latitude, longitude, depth, circleSize);