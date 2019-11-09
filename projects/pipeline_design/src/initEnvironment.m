function [soil, offshoreSpectras, inshoreSpectras] = ...
    initEnvironment()
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
allYear = Jonswap([1, 10, 100, 10000], [11.7, 13.9, 16.0, 20.0], ...
    [15.9, 17.0, 18.0, 20.0]);
spring = Jonswap([1, 10, 100], [9.3, 11.4, 13.3], [14.6, 15.9, 17.0]);
summer = Jonswap([1, 10, 100], [5.8, 7.1, 8.3], [12.3, 13.3, 14.1]);
autumn = Jonswap([1, 10, 100], [9.7, 11.8, 13.6], [14.8, 16.1, 17.0]);
winter = Jonswap([1, 10, 100], [11.6, 14.0, 16.0], [16.0, 17.2, 18.0]);

offshoreSpectras = containers.Map;
offshoreSpectras('allYear') = allYear;
offshoreSpectras('spring') = spring;
offshoreSpectras('summer') = summer;
offshoreSpectras('autumn') = autumn;
offshoreSpectras('winter') = winter;

%% Inshore wave spectras
% Jonswap(returnPeriods, waveHeights, peakPeriods)
allYear = Jonswap([1, 10, 100], [2, 2.5, 3], [4, 5, 6]);
spring = Jonswap([1, 10, 100], [1.5, 2.5, 3], [4, 5, 6]);
summer = Jonswap([1, 10, 100], [1, 1.5, 2], [3, 3.5, 4]);
autumn = Jonswap([1, 10, 100], [1.5, 2, 2.5], [3.5, 4.5, 5.5]);
winter = Jonswap([1, 10, 100], [2, 2.5, 3], [4, 5, 6]);

inshoreSpectras = containers.Map;
inshoreSpectras('allYear') = allYear;
inshoreSpectras('spring') = spring;
inshoreSpectras('summer') = summer;
inshoreSpectras('autumn') = autumn;
inshoreSpectras('winter') = winter;

end