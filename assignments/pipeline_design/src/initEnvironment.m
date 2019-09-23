function [soil, osSpectras, isSpectras, current] = initEnvironment()
%% Soil
friction = 0.2;
dryWeight = 18*10^3; % N/m^3
submergedWeight = 8*10^3; % N/m^3
offshoreShear = 2*10^3; % Pa
inshoreShear = 5*10^3; % Pa

soil = Soil(friction, dryWeight, submergedWeight, offshoreShear, ...
    inshoreShear);

%% Offshore wave spectras
% Jonswap(returnPeriods, waveHeights, peakPeriods)
osAllYear = Jonswap([1, 10, 100, 10000], [11.7, 13.9, 16.0, 20.0], ...
    [15.9, 17.0, 18.0, 20.0]);
osSpring = Jonswap([1, 10, 100], [9.3, 11.4, 13.3], [14.6, 15.9, 17.0]);
osSummer = Jonswap([1, 10, 100], [5.8, 7.1, 8.3], [12.3, 13.3, 14.1]);
osAutumn = Jonswap([1, 10, 100], [9.7, 11.8, 13.6], [14.8, 16.1, 17.0]);
osWinter = Jonswap([1, 10, 100], [11.6, 14.0, 16.0], [16.0, 17.2, 18.0]);

osSpectras = WaveSpectras(osAllYear, osSpring, osSummer, osAutumn, ...
    osWinter);

%% Inshore wave spectras
% Jonswap(returnPeriods, waveHeights, peakPeriods)
isAllYear = Jonswap([1, 10, 100], [2, 2.5, 3], [4, 5, 6]);
isSpring = Jonswap([1, 10, 100], [1.5, 2.5, 3], [4, 5, 6]);
isSummer = Jonswap([1, 10, 100], [1, 1.5, 2], [3, 3.5, 4]);
isAutumn = Jonswap([1, 10, 100], [1.5, 2, 2.5], [3.5, 4.5, 5.5]);
isWinter = Jonswap([1, 10, 100], [2, 2.5, 3], [4, 5, 6]);

isSpectras = WaveSpectras(isAllYear, isSpring, isSummer, isAutumn, ...
    isWinter);

%% Current profile
% Current(returnPeriods, velocities)
current = Current([1, 10, 100], [0.5, 0.55, 0.6]);
end

