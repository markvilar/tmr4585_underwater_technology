clear all; clc;

resultFolder = '../results';

%% Format Harald CTD data
dataFolder = '../data/harald_csv/';
fileName = 'CTD_geo.csv';
filePath = strcat(dataFolder, '/', fileName);

table = readtable(filePath);

% Combine table columns into the acutal data
start = table(:,1:6);
altitude = combineTableColumns(table(:,7), table(:,8));
depth = combineTableColumns(table(:,9), table(:,10));
medium = table(:,11);
conductivity = combineTableColumns(table(:,12), table(:,13));
temperature = combineTableColumns(table(:,14), table(:,15));
salinity = combineTableColumns(table(:,16), table(:,17));

% Change headers
start.Properties.VariableNames = {'timestamp', 'gmtTime', 'latitude', ...
    'longitude', 'latitudeCorr', 'longitudeCorr'};
altitude.Properties.VariableNames = {'altitude'};
depth.Properties.VariableNames = {'depth'};
medium.Properties.VariableNames = {'medium'};
conductivity.Properties.VariableNames = {'conductivity'};
temperature.Properties.VariableNames = {'temperature'};
salinity.Properties.VariableNames = {'salinity'};

table = [start altitude depth medium conductivity temperature salinity];
writetable(table, 'CTD.csv');