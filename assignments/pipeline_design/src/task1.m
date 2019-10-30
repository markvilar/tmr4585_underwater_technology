%% Burst criterion
nSamples = [20, 10, 10, 10, 10, 20];

% Design bursting criterion
designT1s = calcBurstingCriterion(pipeSegments, 5, false, Po, rhoSw, ...
    designDens, gravity, incPress, refHeight, nSamples);

% Test bursting criterion
testT1s = calcBurstingCriterion(pipeSegments, 1, true, Po, rhoSw, ...
    testDens, gravity, testPress, refHeight, nSamples);

% Get maximum thicknesses for each segment for design and test
nSegs = length(pipeSegments);
designMaxT1s = zeros(nSegs, 1);
testMaxT1s = zeros(nSegs, 1);
designMaxTs = zeros(nSegs, 1);
testMaxTs = zeros(nSegs, 1);
maxT1s = zeros(nSegs, 1);
for n = 1:nSegs
    segment = pipeSegments(n);
    designMaxT1s(n) = max(designT1s{n}); % Max req. design t1
    testMaxT1s(n) = max(testT1s{n}); % Max req. test t1
    designMaxTs(n) = segment.calcTFromT1(designMaxT1s(n), true);
    testMaxTs(n) = segment.calcTFromT1(testMaxT1s(n), true);
    maxT1s(n) = max(designMaxT1s(n), testMaxT1s(n)); % Max req. t1
    segment = segment.setTFromT1(maxT1s(n), true); % Set t
end