function [T0s, Rmins, Isteel, Iconc] = calcCatenary(segments, soil, ...
    subWeights, Mcrs, Esteel, Econc, theta)
% Calculates the minimum required bottom tension and the minimum
% horizontal radius of curvature for each pipe segment according to the
% catenary equations.
% arg segments: Nx1 array of PipeSegment objects
% arg soil: Soil object
% arg subWeights: Nx1 array of floats
% arg Mcrs: Nx1 array of floats, the critical bending moments
% arg Esteel: float
% arg Econc: float
% arg theta: float
% return T0s: Nx1 array of floats
% return Rmins: Nx1 array of floats
% return Isteel: Nx1 array of floats
% return Iconc: Nx1 array of floats
nSegs = length(segments);
Isteel = zeros(nSegs, 1);
Iconc = zeros(nSegs, 1);
T0s = zeros(nSegs, 1);
Rmins = zeros(nSegs, 1);

for i = 1:nSegs
    segment = segments(i);
    Mcr = Mcrs(i);
    ws = subWeights(i);
    Is = segment.calcISteel();
    Ic = segment.calcIConc();
    EI = Esteel*Is + Econc*Ic;
    muY = soil.friction;
    t0 = (ws*EI/Mcr)*cos(theta)^2; % Equation 31 in OL
    Rmin = t0/(muY*ws); % Equation 33 in OL
    Isteel(i) = Is;
    Iconc(i) = Ic;
    T0s(i) = t0;
    Rmins(i) = Rmin;
end
end