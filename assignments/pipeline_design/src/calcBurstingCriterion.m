function tMins = calcBurstingCriterion(segments, fluidClass, targets, ...
    Po, rhoE, rhoI, g, Pref, yref, nSamples)
% Calculates the minimum pipe steel wall thickness according to 
% DNV-OS-F101 section 5D.
% arg segments: Nx1 array of PipeSegment objects
% arg fluidClass: int
% arg targets: Mx2 array, human locations
% arg po: float, atmospheric pressure
% arg rhoE: float, sea water density
% arg rhoI: float, internal fluid density
% arg g: float, gravitational acceleration
% arg Pref: float, reference pressure
% arg yref: float, reference height
% arg Ks: Kx1 array of ints, number of sample points along each segment
% return: cell array of vectors, the minimum thicknesses along each segment
assert(length(segments) == length(nSamples), "Number of segments and amount " ...
    + "sample points must be the same.");
N = length(segments);
tMins = cell(N,1);
for i = 1:N
    nSample = nSamples(i);
    ts = zeros(nSample,1);
    segment = segments(i);
    [fy, fu] = segment.getMaterialStrength();
    fcb = min([fy, fu/1.15]); % Equation 5.9
    Di = segment.getInnerDiameter();
    for j = 1:nSample
        frac = (j-1)*(1/(nSample-1));
        [x, y] = segment.getXY(frac);
        hDdist = segment.minHDistToTargets(frac, targets);
        [alphaMpt, alphaSpt, gammas] = segment.getResistFactors(hDdist, ...
            fluidClass);
        Pe = Po - rhoE*g*min(y, 0); % External pressure
        Pi = Pref - rhoI*g*(y - yref); % Internal pressure
        ts(j) = (alphaMpt*Di)*(Pi-Pe) / (2*0.96*fcb); % Eq. 5.7, 5.8 and table 5-9
    end
    tMins{i} = ts;
end
end