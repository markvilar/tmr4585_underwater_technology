clear all; clc;

resultFolder = '../results';

%% Read vessel CTD data
dataFolder = '../data/vessel_ctd';
fileName = '20190926_140000.asvp';
filePath = strcat(dataFolder, '/', fileName);

fid = fopen(filePath, 'r');
header = fgetl(fid);
line = fgetl(fid);
i = 1;

while isa(line, 'char')
    fprintf('%s\n', line); % char
    data(1:2, i) = str2double(line);
    line = fgetl(fid);
    i = i + 1;
end

depthVessel = data(1, :);
soundSpeedVessel = data(2, :);
resultPath = strcat(resultFolder, '/', 'soundSpeed.mat');
save(resultPath, 'depthVessel', 'soundSpeedVessel');

fclose(fid);