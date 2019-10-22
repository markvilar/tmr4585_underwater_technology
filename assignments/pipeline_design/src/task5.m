%% The most conservative maximum allowable free span
nSamples = [20, 10, 10, 10, 10, 20];

maxMoment = 0.0197;
t_corr = 0.002;
t_2_prior_operation = maxMoment + t_corr;
t_2_operation = maxMoment;

% Design max moment
designMoment = calcMaxDesignMoment(pipeSegments, flow, targets, Po, rhoSw, ...
    designDens, gravity, designPress, designRef, nSamples,t_2_operation);

% Test max moment
testMoment = calcMaxDesignMoment(pipeSegments, flow, targets, Po, rhoSw, ...
    testDens, gravity, testPress, testRef, nSamples,t_2_prior_operation);

%Installation max moment
installationMoment = calcMaxDesignMoment(pipeSegments, flow, targets, Po, rhoSw, ...
    installDens, gravity, installPress, installRef, nSamples,t_2_prior_operation);

% Get maximum thicknesses for each segment for design and test
nSegs = length(pipeSegments);
designTempMaxMoment = zeros(nSegs, 1);
testTempMaxMoment = zeros(nSegs, 1);
installationTempMaxMoment = zeros(nSegs, 1);

maxTempOverallMoment = zeros(nSegs, 1);
for n = 1:nSegs
    designM = designMoment{n};
    testM = testMoment{n};
    installM = installationMoment{n};
    designTempMaxMoment(n) = max(designM);
    testTempMaxMoment(n) = max(testM);
    installationTempMaxMoment(n) = max(installM);
    maxTempOverallMoment(n) = max(designTempMaxMoment(n), testTempMaxMoment(n), installatioTempnMaxMoment(n));
end

designMaxMoment = max(designTempMaxMoment);
testMaxMoment = max(testTempMaxMoment);
installationMaxMoment = max(installationTempMaxMoment);
maxOverallMoment = max(maxTempOverallMoment);