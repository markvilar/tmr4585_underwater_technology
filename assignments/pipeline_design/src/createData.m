function pipeline = createData()
%% General design parameters
designPressure = 25; % MPa
testPressure = 4/3 * designPressure; % MPa
incidentPressure = testPressure; % MPa

%% Material
tolerance = 0.10; % -
density = 7850; % kg/m^3
yieldStress = 450; % MPa
tensileStrength = 1.15*yieldStress; % MPa

material = Material(tolerance, density, yieldStress, tensileStrength);

%% Tube
innerDiameter = 406.4; % mm
ovality = 0.005; % -

tube = Tube(innerDiameter, ovality, material);

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

%% Connections
% Connection(submergedHeight, locationClass)
kp000 = Connection(-20, 0, true, 2);
kp001 = Connection(300, 0, true, 2);
kp090 = Connection(300, 90, true, 1);
kp091 = Connection(300, 90, false, 1);
kp100 = Connection(100, 100, false, 1);
kp105 = Connection(100, 105, false, 1);
kp115 = Connection(115, 115, false, 1);
kp150 = Connection(-20, 150, false, 2);

connections = [kp000, kp001, kp090, kp091, kp100, kp105, kp115, kp150];

for i = 1:length(connections)
    connections(i) = connections(i).setSafetyClass(fluidClass);
end

%% Offshore wave spectras
% Jonswap(returnPeriods, waveHeights, peakPeriods)
osAllYear = Jonswap([1, 10, 100, 10000], [11.7, 13.9, 16.0, 20.0], ...
    [15.9, 17.0, 18.0, 20.0]);
osSpring = Jonswap([1, 10, 100], [9.3, 11.4, 13.3], [14.6, 15.9, 17.0]);
osSummer = Jonswap([1, 10, 100], [5.8, 7.1, 8.3], [12.3, 13.3, 14.1]);
osAutumn = Jonswap([1, 10, 100], [9.7, 11.8, 13.6], [14.8, 16.1, 17.0]);
osWinter = Jonswap([1, 10, 100], [11.6, 14.0, 16.0], [16.0, 17.2, 18.0]);

offshoreSpectras = WaveSpectras(osAllYear, osSpring, osSummer, osAutumn, ...
    osWinter);

%% Inshore wave spectras
% Jonswap(returnPeriods, waveHeights, peakPeriods)
isAllYear = Jonswap([1, 10, 100], [2, 2.5, 3], [4, 5, 6]);
isSpring = Jonswap([1, 10, 100], [1.5, 2.5, 3], [4, 5, 6]);
isSummer = Jonswap([1, 10, 100], [1, 1.5, 2], [3, 3.5, 4]);
isAutumn = Jonswap([1, 10, 100], [1.5, 2, 2.5], [3.5, 4.5, 5.5]);
isWinter = Jonswap([1, 10, 100], [2, 2.5, 3], [4, 5, 6]);

inshoreSpectras = WaveSpectras(isAllYear, isSpring, isSummer, isAutumn, ...
    isWinter);

%% Current profile
% Current(returnPeriods, velocities)
current = Current([1, 10, 100], [0.5, 0.55, 0.6]);

%% Pipeline

pipeline = Pipeline(designPressure, testPressure, incidentPressure, ...
    flow, tube, connections, soil, offshoreSpectras, inshoreSpectras, ...
    current);

end