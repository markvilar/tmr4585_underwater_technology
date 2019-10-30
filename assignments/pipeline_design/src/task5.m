%% The most conservative maximum allowable free span
nSamples = [20, 10, 10, 10, 10, 20];

maxMoment = 0.0197;
t_corr = 0.002;
t_2_prior_operation = maxMoment + t_corr;
t_2_operation = maxMoment;

% Design/operation max moment, internal pressure
operation = 1;
test = 0;
fluidClass = 5;
MaxDesignMomentSegments = calcMaxMoment(pipeSegments, fluidClass, test, Po, rhoSw, ...
    designDens, gravity, designPress, designRef, nSamples, operation);

% Test max moment, internal pressure
operation = 0;
test = 1;
fluidClass = 1;
MaxTestMomentSegments = calcMaxMoment(pipeSegments, fluidClass, test, Po, rhoSw, ...
    testDens, gravity, testPress, testRef, nSamples, operation);

%Installation max moment
operation = 0;
test = 0;
fluidClass = 1;
MaxInstallationMomentSegments = calcMaxMoment(pipeSegments, fluidClass, test, Po, rhoSw, ...
    installDens, gravity, installPress, installRef, nSamples, operation);

% Get maximum moment for each segment for design, test and installation
nSegs = length(pipeSegments);
designSegmentMaxMoment = zeros(nSegs, 1);
testSegmentMaxMoment = zeros(nSegs, 1);
installationSegmentMaxMoment = zeros(nSegs, 1);

maxSegmentOverallMoment = zeros(nSegs, 1);
%For each segment, get the max moment from the samples
for n = 1:nSegs
    designSegmentSamplesM = MaxDesignMomentSegments{n};
    testSegmentSamplesM = MaxTestMomentSegments{n};
    installSegmentSamplesM = MaxInstallationMomentSegments{n};
    designSegmentMaxMoment(n) = max(designSegmentSamplesM);
    testSegmentMaxMoment(n) = max(testSegmentSamplesM);
    installationSegmentMaxMoment(n) = max(installSegmentSamplesM);
    maxSegmentOverallMoment(n) = max(designSegmentMaxMoment(n), testSegmentMaxMoment(n), installatioTempnMaxMoment(n));
end

%Finding the maximum moment out of all segments
designMaxMoment = max(designSegmentMaxMoment);
testMaxMoment = max(testSegmentMaxMoment);
installationMaxMoment = max(installationSegmentMaxMoment);
maxOverallMoment = max(maxSegmentOverallMoment);

%Calculating the maximum allowable spanning length
designMaxSpanlength = calcMaxSpanLength(ws,designMaxMoment);
testMaxSpanLength = calcMaxSpanLength(ws,testMaxMoment);
installationMaxSpanLength = calcMaxSpanLength(ws, installationMaxMoment);



function spanLength = calcMaxSpanLength(ws, maxMoment)
    spanLength = sqrt(12*(maxMoment/ws));
end
