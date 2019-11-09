function [T0s, Rmins] = calcCatenary(segments, soil, ...
    subWeights, Mcrs, theta)
% Calculates the minimum required bottom tension and the minimum
% horizontal radius of curvature for each pipe segment according to the
% catenary equations.
% arg segments: Nx1 array of PipeSegment objects
% arg soil: Soil object
% arg subWeights: Nx1 array of floats
% arg Mcrs: Nx1 array of floats, the critical bending moments
nSegs = length(segments);
T0s = zeros(nSegs, 1);
Rmins = zeros(nSegs, 1);

for i = 1:nSegs
    segment = segments(i);
    Mcr = Mcrs(i);
    ws = subWeights(i);
    ISteel = segment.calcISteel();
    [~, ~, ~, ESteel] = segment.getMaterialProperties();
    muY = soil.friction;
    t0 = (ws*ESteel*ISteel/Mcr)*cos(theta)^2; % Equation 31 in OL
    Rmin = t0/(muY*ws); % Equation 33 in OL
    T0s(i) = t0;
    Rmins(i) = Rmin;
end
end