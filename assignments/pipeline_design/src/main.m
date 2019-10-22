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
designRef = 20; % m
designDens = 300; % kg/m^3

%% Test condition
testPress = 4/3*designPress; % Pa
testRef = 20; % m
testDens = 1000; % kg/m^3

%% Installation condition 
installPress = 0; %Pa
installRef = 20; % m
installDens = 1.2; % kg/m^3

%% Tasks
run('task1.m')
run('task2.m')
%   run('task3.m')