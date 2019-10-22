%% Misc.
clear all
clc

%% Initialization of objects
[pipeSegments, flow, targets] = initDesign();
[soil, osSpectras, isSpectras, current] = initEnvironment();

%% General constants
rhoSw = 1025; % kg/m^3
rhoW = 1000; % kg/m^3
rhoAir = 1.225; % kg/m^3
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

%% Tasks
run('task1.m')
run('task2.m')
run('task3.m')