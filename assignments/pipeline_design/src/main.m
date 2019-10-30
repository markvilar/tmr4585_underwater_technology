%% Misc.
clear all
clc

%% Initialization of objects
[pipeSegments, flow] = initDesign();
[soil, osSpectras, isSpectras] = initEnvironment();

%% General constants
rhoSw = 1025; % kg/m^3
rhoW = 1000; % kg/m^3
Po = 0.101*10^6; % Pa (Atmospheric pressure)
gravity = 9.81; % m/s^2

%% Design condition
designPress = 25*10^6; % Pa
designDens = 300; % kg/m^3

%% Incidental condition
incPress = 1.33*designPress;

%% Test condition
testPress = 4/3*designPress; % Pa
testDens = 1000; % kg/m^3
refHeight = 20; % m

%% Installation condition 
installPress = 0; %Pa
installRef = 20; % m
installDens = 1.2; % kg/m^3

%% Lateral stability
%installation: empty pipe - summer
latParams_inst = calcLateralStability(submergedWeight, rho, gravity, soil, pipeSegments, thickness, osSpectras('summer'), isSpectras('summer'));
%system test: water filled - winter
latParams_test = calcLateralStability(submergedWeight, rho, gravity, soil, pipeSegments, thickness, osSpectras('winter'), isSpectras('winter'));
%operation: gas filled - spring?
latParams_inst = calcLateralStability(submergedWeight, rho, gravity, soil, pipeSegments, thickness, osSpectras('spring'), isSpectras('spring'));
% NEED: submergedWeight pipe and thickness pipe (t). 

%% Tasks
run('task1.m')
% run('task2.m')
% run('task3.m')