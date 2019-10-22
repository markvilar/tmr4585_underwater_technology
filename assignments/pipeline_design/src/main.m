%% Initialization of objects
[pipeSegments, flow, targets] = initDesign();
[soil, osSpectras, isSpectras, current] = initEnvironment();

%% General constants
rho = 1025; % kg/m^3
Po = 0.101*10^6; % Pa (Atmospheric pressure)
gravity = 9.81; % m/s^2

%% Design condition
designPress = 25*10^6; % Pa
designRef = 20; % m
designDens = 300; % kg/m^3

%% Test condition
testPress = 4/3*designPress; % Pa
testRef = 20; % m
testDens = 1000; % kg/m^3

%% Burst criterion
% Design criterion
calcBurstingCriterion(pipeSegments, flow, targets, Po, rho, designDens, ...
    gravity, designPress, designRef, 10)

% Test criterion

%% Lateral stability
[latParams] = calcLateralStability(submergedWeight, rho, gravity, soil );