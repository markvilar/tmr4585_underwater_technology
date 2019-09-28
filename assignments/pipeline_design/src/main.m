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
nSamples = [20, 10, 10, 10, 10, 20];

% Design bursting criterion
designTs = calcBurstingCriterion(pipeSegments, flow, targets, Po, rho, ...
    designDens, gravity, designPress, designRef, nSamples);

% Test bursting criterion
testTs = calcBurstingCriterion(pipeSegments, flow, targets, Po, rho, ...
    testDens, gravity, testPress, testRef, nSamples);

% Get maximum thicknesses
nSegs = length(designTs);
designMaxTs = zeros(nSegs, 1);
testMaxTs = zeros(nSegs, 1);
for n = 1:nSegs
    designT = designTs{n};
    testT = testTs{n};
    designMaxTs(n) = max(designT);
    testMaxTs(n) = max(testT);
end

%% Buckling arrestor criterion
alphaFab = 1.00;
Pmin = Po;

bucklingArrestors = calcArrestorCriterion(pipeSegments, flow, targets, ...
    Po, rho, gravity, Pmin, alphaFab, designMaxTs, nSamples);