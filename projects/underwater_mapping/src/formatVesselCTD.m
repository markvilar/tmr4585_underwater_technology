clear all; clc;

%% Results
resultFolder = '../results';
resultFile = 'CTD_gunnerus.csv';
resultPath = strcat(resultFolder, '/', resultFile);

%% Read vessel CTD data
dataFolder = '../data/vessel_ctd';
fileName = '20190926_140000.asvp';
filePath = strcat(dataFolder, '/', fileName);

fid = fopen(filePath, 'r');
header = fgetl(fid);
line = fgetl(fid);
i = 1;

while isa(line, 'char')
    data(:,i) = str2num(line);
    line = fgetl(fid);
    i = i + 1;
end

depth = data(1, :);
soundSpeed = data(2, :);

% Create table
results = table(depth(:), soundSpeed(:), 'VariableNames', ...
    {'depth', 'soundSpeed'});

% Write to file
writetable(results, resultPath);

fclose(fid);