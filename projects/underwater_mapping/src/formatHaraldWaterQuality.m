clear all; clc;

%% Results
resultFolder = '../results';
resultFile = 'water_quality_harald_corrected.csv';
resultPath = strcat(resultFolder, '/', resultFile);

%% Read data
dataFolder = '../data/harald_csv';
wqFile = 'water_quality.csv';
doFile = 'DissolvedOxygen.csv';

% Water quality (Chlorophyll a, cDom)
wqPath = strcat(dataFolder, '/', wqFile);
opts = detectImportOptions(wqPath);
wqHead = preview(wqPath, opts);
wqTable = readtable(wqPath);

% Disolved
doPath = strcat(dataFolder, '/', doFile);
opts = detectImportOptions(wqPath);
doHead = preview(doPath, opts);
doTable = readtable(doPath);

%% Format water quality data
% [time, latitude, longitude, depth, altitude, chlorophyll, cDom]
wqTime = table(table2array(wqTable(:, 1))/1000);
latitude = combineTableColumns(wqTable(:, 2), wqTable(:, 3));
longitude = combineTableColumns(wqTable(:, 4), wqTable(:, 5));
depth = combineTableColumns(wqTable(:, 6), wqTable(:, 7));
altitude = combineTableColumns(wqTable(:, 8), wqTable(:, 9));
chlorophyll = combineTableColumns(wqTable(:, 10), wqTable(:, 11));
cDom = combineTableColumns(wqTable(:, 12), wqTable(:, 13));

% Change headers
wqTime.Properties.VariableNames = {'Time'};
latitude.Properties.VariableNames = {'Latitude'};
longitude.Properties.VariableNames = {'Longitude'};
depth.Properties.VariableNames = {'Depth'};
altitude.Properties.VariableNames = {'Altitude'};
chlorophyll.Properties.VariableNames = {'Chlorophyll'};
cDom.Properties.VariableNames = {'cDOM'};

% WQ table assembly
wqTable = [wqTime, latitude, longitude, depth, altitude, chlorophyll, cDom];

%% Dissolved oxygen binning
timePad = 1; % Add 1 second padding to outer time binning intervals

doTable = [doTable(:, 1), doTable(:, 4)];

binnedOxygen = arrayTimeBinning(table2array(wqTime), table2array(doTable), timePad);
binnedOxygen = averageCells(binnedOxygen);
binnedOxygen = interpolateCells(binnedOxygen);
binnedOxygen = cell2mat(binnedOxygen);

%% Format oxygen table
doTable = [wqTime, table(binnedOxygen)];
doTable.Properties.VariableNames = {'Time', 'DissolvedOxygen'};

%% Assemble table and write to csv file
resultsTable = [wqTable, doTable(:, 2)];
writetable(resultsTable, resultPath); % Write to file