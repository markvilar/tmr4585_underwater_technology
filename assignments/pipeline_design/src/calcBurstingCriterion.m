function ts = calcBurstingCriterion(segments, flow, targets, Po, rhoE, rhoI, ...
    g, Pref, yref, m)
% Calculates the minimum pipe steel wall thickness according to 
% DNV-OS-F101 section 5.
% arg segments: 1xN array of PipeSegment objects
% arg flow: Flow object
% arg targets: Kx2 array, human locations
% arg Po: float, atmospheric pressure
% arg rhoE: float, sea water density
% arg rhoI: float, internal fluid density
% arg g: float, gravitational acceleration
% arg Pref: float, reference pressure
% arg yref: float, reference height
% arg m: int, number of sample points along each segment
% return: MxN array of floats
fluidClass = flow.getFluidClass();
n = length(segments);
k = length(targets);
ts = zeros(m, n);
for i = 1:n
    segment = segments(i);
    [fy, fu] = segment.getMaterialStrength();
    fcb = min([fy, fu/1.15]); % Equation 5.9
    Di = segment.getInnerDiameter();
    for j = 1:m
        frac = (j-1)*(1/(m-1));
        dist = segment.minDistToTargets(frac, targets);
        [alphaMpt, alphaSpt] = segment.getResistFactors(dist, fluidClass);
    end
end
end