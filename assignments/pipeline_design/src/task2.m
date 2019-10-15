%% Buckling arrestor criterion
alphaFab = 1.00;
Pmin = Po;

bucklingArrestors = calcArrestorCriterion(pipeSegments, flow, targets, ...
    Po, rhoSw, gravity, Pmin, alphaFab, minTs, nSamples);