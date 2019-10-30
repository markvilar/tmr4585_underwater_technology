function [pipeSegments, flow] = initDesign()
%% Corrosion coating
tCorr = 2*10^(-3); % m
rhoCorr = 1100; % kg/m^3
kCorr = 0.2; % W/m/K

%% Concrete coating
tConcMin = 45*10^(-3); % m
rhoConc = 3000; % kg/m^3 2200-3000
kConc = 0.5; % W/m/K

%% Material
allowance = 5*10^(-3); % m
tolerance = 0.10; % -
density = 7850; % kg/m^3
SMYS = 450*10^6; % Pa
SMYT = 1.15*SMYS; % Pa
thermCon = 43; % W/m/K
gammaM = 1.15;

material = Material(allowance, tolerance, density, SMYS, SMYT, ...
    thermCon, gammaM);

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
Di = 406.4*10^(-3); % m
ovality = 0.005; % -

seg1 = PipeSegment(kp000, kp001, 3, Di, ovality, material, tCorr, ...
    rhoCorr, kCorr, tConcMin, rhoConc, kConc);
seg2 = PipeSegment(kp001, kp090, 2, Di, ovality, material, tCorr, ...
    rhoCorr, kCorr, tConcMin, rhoConc, kConc);
seg3 = PipeSegment(kp090, kp100, 2, Di, ovality, material, tCorr, ...
    rhoCorr, kCorr, tConcMin, rhoConc, kConc);
seg4 = PipeSegment(kp100, kp105, 3, Di, ovality, material, tCorr, ...
    rhoCorr, kCorr, tConcMin, rhoConc, kConc);
seg5 = PipeSegment(kp105, kp115, 3, Di, ovality, material, tCorr, ...
    rhoCorr, kCorr, tConcMin, rhoConc, kConc);
seg6 = PipeSegment(kp115, kp150, 3, Di, ovality, material, tCorr, ...
    rhoCorr, kCorr, tConcMin, rhoConc, kConc);

pipeSegments = [seg1, seg2, seg3, seg4, seg5, seg6];

%% Flow
fluidClass = 5;
inletTemperature = 80 + 273; % K
velocity = 5; % m/s
heatCapacity = 2000; % J/kg/K
density = 250; % kg/m^3

flow = Flow(fluidClass, inletTemperature, velocity, heatCapacity, density);

end