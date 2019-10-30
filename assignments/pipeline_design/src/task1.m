%% Burst criterion
nSamples = [20, 10, 10, 10, 10, 20];

% Design bursting criterion
designTs = calcBurstingCriterion(pipeSegments, 5, Po, rhoSw, ...
    designDens, gravity, incPress, refHeight, nSamples);

% Test bursting criterion
testTs = calcBurstingCriterion(pipeSegments, 1, Po, rhoSw, ...
    testDens, gravity, testPress, refHeight, nSamples);

% Get maximum thicknesses for each segment for design and test
nSegs = length(pipeSegments);
designMaxT1s = zeros(nSegs, 1);
testMaxT1s = zeros(nSegs, 1);
maxT1s = zeros(nSegs, 1);
for n = 1:nSegs
    designMaxT1s(n) = max(designTs{n}); % Extract segment max req. thickness
    testMaxT1s(n) = max(testTs{n}); % Extract segment max req. thickness
    maxT1s(n) = max(designMaxT1s(n), testMaxT1s(n));
    pipeSegments(n) = pipeSegments(n).setTFromT1(maxT1s(n));
end