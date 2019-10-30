function results = calcArrestorCriterion(segments, fluidClass, targets, Po, ...
    rhoE, g, Pmin, alphaFab, ts, nSamples)
% Calculates the need for buckling arrestors along pipeline segments
% according to DNV-OS-F101 section 5D.
% arg segments: Nx1 array of objects
% arg Po: float, atmospheric pressure
% arg rhoE: float, sea water density
% arg g: float, gravitational acceleration
% arg Pmin: float, minimum occuring pressure
% arg alphaFab: float, fabrication factor
% arg nSamples: Nx1 array of ints
% return: Nx1 cell array of vectors
assert(length(segments) == length(nSamples) && ...
    length(segments) == length(ts), "Number of segments, thicknesses " ...
    + "and the amount of sample points must be the same.");
nSegs = length(segments);
results = cell(nSegs, 1);

for i = 1:nSegs
    segment = segments(i);
    nSample = nSamples(i);
    [fy, fu] = segment.getMaterialStrength();
    Di = segment.getInnerDiameter();
    % Get relevant thickness
    t2 = segment.calcT2(false);
    result = true(nSample, 1);
    for j = 1:nSample
        frac = (j-1)*(1/(nSample-1));
        [~, y] = segment.getXY(frac);
        hDdist = segment.minHDistToTargets(frac, targets);
        [gammaM, gammaSC] = segment.getResistFactors(hDdist, ...
            fluidClass);
        Pe = Po - rhoE*g*min(y, 0);
        Ppr = 35*fy*alphaFab*(t2/Di)^(2.5); % Eq. 5.16
        result(j) = ~((Pe - Pmin) <= Ppr/(gammaM*gammaSC)); % Eq. 5.15
    end
    results{i} = result;
end
end