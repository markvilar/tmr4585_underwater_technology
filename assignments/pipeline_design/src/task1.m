%% Burst criterion
nSamples = [20, 10, 10, 10, 10, 20];

% Design bursting criterion
designTs = calcBurstingCriterion(pipeSegments, flow, targets, Po, rhoSw, ...
    designDens, gravity, designPress, designRef, nSamples);

% Test bursting criterion
testTs = calcBurstingCriterion(pipeSegments, flow, targets, Po, rhoSw, ...
    testDens, gravity, testPress, testRef, nSamples);

% Get maximum thicknesses for each segment for design and test
nSegs = length(pipeSegments);
designMaxTs = zeros(nSegs, 1);
testMaxTs = zeros(nSegs, 1);
maxTs = zeros(nSegs, 1);
minTs = zeros(nSegs, 1);
for n = 1:nSegs
    designT = designTs{n};
    testT = testTs{n};
    designMaxTs(n) = max(designT);
    testMaxTs(n) = max(testT);
    maxTs(n) = max(designMaxTs(n), testMaxTs(n));
    minTs(n) = min(designMaxTs(n), testMaxTs(n));
    pipeSegments(n) = pipeSegments(n).setT(maxTs(n));
end