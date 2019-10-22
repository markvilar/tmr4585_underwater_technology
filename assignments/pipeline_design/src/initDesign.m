function [pipeSegments, flow, targets] = initDesign()
%% Corrosion coating
corrThick = 2*10^(-3); % m
corrDens = 1100; % kg/m^3
corrThermCon = 0.2; % W/m/K

corrCoating = Coating(corrThick, corrDens, corrThermCon);

%% Concrete coating
concThick = 45*10^(-3); % m
concDens = 3000; % kg/m^3 2200-3000
concThermCon = 0.5; % W/m/K

concCoating = Coating(concThick, concDens, concThermCon);

%% Material
allowance = 5*10^(-3); % m
tolerance = 0.10; % -
density = 7850; % kg/m^3
SMYS = 450*10^6; % Pa
SMYT = 1.15*SMYS; % Pa
thermCon = 43; % W/m/K

material = Material(allowance, tolerance, density, SMYS, SMYT, ...
    thermCon);

%% Connections
% Connection(x, y)
kp000 = Connection(0, -300);
kp001 = Connection(500, -300);
kp090 = Connection(90000, -300);
kp100 = Connection(100000, -100);
kp105 = Connection(105000, -100);
kp115 = Connection(115000, -300);
kp150 = Connection(150000, 20);

%% Pipeline segments
innerD = 406.4*10^(-3); % m
ovality = 0.005; % -

% PipeSegment(startConn, endConn, isOffshore, innerD, ovality, material, ...
%       corrCoat, concCoat, isRiser)
seg1 = PipeSegment(kp000, kp001, true, innerD, ovality, material, ...
    corrCoating, concCoating, true);
seg2 = PipeSegment(kp001, kp090, true, innerD, ovality, material, ...
    corrCoating, concCoating, false);
seg3 = PipeSegment(kp090, kp100, true, innerD, ovality, material, ...
    corrCoating, concCoating, false);
seg4 = PipeSegment(kp100, kp105, false, innerD, ovality, material, ...
    corrCoating, concCoating, false);
seg5 = PipeSegment(kp105, kp115, false, innerD, ovality, material, ...
    corrCoating, concCoating, false);
seg6 = PipeSegment(kp115, kp150, false, innerD, ovality, material, ...
    corrCoating, concCoating, false);

pipeSegments = [seg1, seg2, seg3, seg4, seg5, seg6];

%% Flow
fluidClass = 5;
inletTemperature = 80 + 273; % K
velocity = 5; % m/s
heatCapacity = 2000; % J/kg/K
density = 250; % kg/m^3

flow = Flow(fluidClass, inletTemperature, velocity, heatCapacity, density);

%% Platform and factory location
target1 = [0, 20];
target2 = [150000, 20];
targets = [target1; target2];
end