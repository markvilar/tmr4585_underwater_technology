%% Buckling arrestor criterion
alphaFab = 1.00;
Pmin = Po;

bucklingArrestors = calcArrestorCriterion(pipeSegments, 5, false, Po, ...
    rhoSw, gravity, Pmin, alphaFab, nSamples);