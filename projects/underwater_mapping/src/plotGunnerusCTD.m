clear all; clc;

%% Figures
figuresFolder = '../figures';

%% Read data
dataFolder = '../results';
dataFile = 'ctd_gunnerus.csv';
dataPath = strcat(dataFolder, '/', dataFile);
opts = detectImportOptions(dataPath);
tableHead = preview(dataPath, opts);
opts.SelectedVariableNames = [1, 2];
data = readmatrix(dataPath, opts);

depth = data(:, 1);
soundSpeed = data(:, 2);

%% Plot
padding = 7;

figure(1); clf;
hold on; grid on;
plot(soundSpeed, depth, 'b');
set(gca, 'YDir','reverse'); % Flip y-axis
xlabel('Speed of Sound [m/s]');
ylabel('Depth [m]');
title('Speed of Sound vs. depth');
xlim([min(soundSpeed)-padding, max(soundSpeed)+padding]);
ylim([0, 200]);