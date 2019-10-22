%% Burst criterion
nSamples = [20, 10, 10, 10, 10, 20];

% Design bursting criterion
designTs = calcBurstingCriterion(pipeSegments, 5, targets, rhoSw, ...
    designDens, gravity, incPress, refHeight, nSamples);

% Test bursting criterion
testTs = calcBurstingCriterion(pipeSegments, 1, targets, rhoSw, ...
    testDens, gravity, testPress, refHeight, nSamples);

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
    pipeSegments(n) = pipeSegments(n).setT(maxTs(n)); % set 
end