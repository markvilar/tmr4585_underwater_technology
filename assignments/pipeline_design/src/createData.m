function design = createData()
%% Design condition
designPress = 25; % MPa
designRef = 20; % m
designDens = 300; % kg/m^3
gravity = 9.81; % m/s^2

designCon = Condition(designPress, designRef, designDens, gravity);

%% Test condition
testPress = 4/3 * designPress; % MPa
testRef = 20; % m
testDens = 1000; % kg/m^3

testCon = Condition(testPress, testRef, testDens, gravity);

%% Installation condition
installPress = 0.101; % MPa (Atmospheric pressure)
installRef = 0; % m
installDens = 1.225; % kg/m^3 (Atmospheric density)

installCon = Condition(installPress, installRef, installDens, gravity);

%% Material
tolerance = 0.10; % -
density = 7850; % kg/m^3
yieldStress = 450; % MPa
tensileStrength = 1.15*yieldStress; % MPa

material = Material(tolerance, density, yieldStress, tensileStrength);

%% Connections
% Connection(submergedHeight, locationClass)
kp000 = Connection(-20, 0, true);
kp001 = Connection(300, 0, true);
kp090 = Connection(300, 90, true);
kp100 = Connection(100, 100, false);
kp105 = Connection(100, 105, false);
kp115 = Connection(115, 115, false);
kp150 = Connection(-20, 150, false);

%% Pipeline segments
insideDia = 406.4; % mm
ovality = 0.005; % -

seg1 = PipeSegment(kp000, kp001, insideDia, ovality, material);
seg2 = PipeSegment(kp001, kp090, insideDia, ovality, material);
seg3 = PipeSegment(kp090, kp100, insideDia, ovality, material);
seg4 = PipeSegment(kp100, kp105, insideDia, ovality, material);
seg5 = PipeSegment(kp105, kp115, insideDia, ovality, material);
seg6 = PipeSegment(kp115, kp150, insideDia, ovality, material);

segments = [seg1, seg2, seg3, seg4, seg5, seg6];

%% Pipeline
pipeline = Pipeline(designCon, testCon, installCon, segments);

%% Flow
fluidClass = 'E';
inletTemperature = 80; % Celsius
velocity = 5; % m/s
heatCapacity = 2000; % J/kg/K
density = 250; % kg/m^3

flow = Flow(fluidClass, inletTemperature, velocity, heatCapacity, density);

%% Soil
friction = 0.2;
dryWeight = 18; % kN/m^3
submergedWeight = 8; % kN/m^3
offshoreShear = 2; % kPa
inshoreShear = 5; % kPa

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

%% Design

design = Design(pipeline, flow, soil, osSpectras, isSpectras, current);

end