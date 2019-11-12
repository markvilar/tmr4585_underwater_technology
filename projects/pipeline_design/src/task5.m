%% The most conservative maximum allowable free span
nSamples = [20, 10, 10, 10, 10, 20];

% Design/operation max moment, internal pressure
operation = 1; %Operation phase
test = 0;      %Is it system test
fluidClass = 5;
MaxDesignMomentSegments = calcMaxMoment(pipeSegments, fluidClass, test, Po, rhoSw, ...
    designDens, gravity, designPress, refHeight, nSamples, operation);

% Design/operation max moment, NO internal pressure
operation = 1; %Operation phase
test = 0;      %Is it system test
fluidClass = 1;
MaxDesignMomentSegmentsNoInternP = calcMaxMoment(pipeSegments, fluidClass, test, Po, rhoSw, ...
    installDens, gravity, installPress, refHeight, nSamples, operation);

% Test max moment, internal pressure
operation = 0;
test = 1;
fluidClass = 1;
MaxTestMomentSegments = calcMaxMoment(pipeSegments, fluidClass, test, Po, rhoSw, ...
    testDens, gravity, testPress, refHeight, nSamples, operation);

% Test max moment, NO internal pressure
operation = 0;
test = 1;
fluidClass = 1;
MaxTestMomentSegmentsNoInternP = calcMaxMoment(pipeSegments, fluidClass, test, Po, rhoSw, ...
    testDens, gravity, installPress, refHeight, nSamples, operation);

%Installation max moment
operation = 0;
test = 0;
fluidClass = 1;
MaxInstallationMomentSegments = calcMaxMoment(pipeSegments, fluidClass, test, Po, rhoSw, ...
    installDens, gravity, installPress, refHeight, nSamples, operation);

% Get maximum moment for each segment for design, test and installation
nSegs = length(pipeSegments);
designSegmentMaxMoment = zeros(nSegs, 1);
designNoInternPSegmentMaxMoment = zeros(nSegs, 1);
testSegmentMaxMoment = zeros(nSegs, 1);
testNoInternPSegmentMaxMoment = zeros(nSegs, 1);
installationSegmentMaxMoment = zeros(nSegs, 1);
installationNoInternPSegmentMaxMoment = zeros(nSegs, 1);

%maxSegmentOverallMoment = zeros(nSegs, 1);
%For each segment, get the max moment from the samples
for n = 1:nSegs
    designSegmentSamplesM = MaxDesignMomentSegments{n};
    designNoInternPSegmentSamplesM = MaxDesignMomentSegmentsNoInternP{n};
    testSegmentSamplesM = MaxTestMomentSegments{n};
    testNoInternPSegmentSamplesM = MaxTestMomentSegmentsNoInternP{n};
    installSegmentSamplesM = MaxInstallationMomentSegments{n};
    designSegmentMaxMoment(n) = min(designSegmentSamplesM);
    designNoInternPSegmentMaxMoment(n) = min(designNoInternPSegmentSamplesM);
    testSegmentMaxMoment(n) = min(testSegmentSamplesM);
    testNoInternPSegmentMaxMoment(n) = min(testNoInternPSegmentSamplesM);
    installationSegmentMaxMoment(n) = min(installSegmentSamplesM);
end

% Getting the critical bending moment for each of the conditions
[criticalBendingMomentDesign, designCritMomIdx] = ...
    min(designSegmentMaxMoment);
[criticalBendingMomentDesignNoInternP, designNoPCritMomIdx] = ...
    min(designNoInternPSegmentMaxMoment);
[criticalBendingMomentTest, testCritMomIdx] = ...
    min(testSegmentMaxMoment);
[criticalBendingMomentTestNoInternP, testNoPCritMomIdx] = ...
    min(testNoInternPSegmentMaxMoment);
[criticalBendingMomentInstallation, installCritMomIdx] = ...
    min(installationSegmentMaxMoment);

 % Calculating the maximum spanning length for each segment
 designMaxSpanLengthSegment = zeros(nSegs, 1);
 desginNoInternPSpanlengthSegment = zeros(nSegs,1);
 testMaxSpanLengthSegment = zeros(nSegs,1);
 testNoInternPMaxSpanLengthSegment = zeros(nSegs,1);
 installationMaxSpanLengthSegment = zeros(nSegs,1);
for n = 1:nSegs
    designMaxSpanLengthSegment(n) = calcMaxSpanLength(w_fgas(n)*1000,designSegmentMaxMoment(n));
    desginNoInternPSpanlengthSegment(n) = calcMaxSpanLength(w_subm(n)*1000, designNoInternPSegmentMaxMoment(n));
    testMaxSpanLengthSegment(n) = calcMaxSpanLength(w_filled(n)*1000,testSegmentMaxMoment(n));
    testNoInternPMaxSpanLengthSegment(n) = calcMaxSpanLength(w_subm(n)*1000,testNoInternPSegmentMaxMoment(n));
    installationMaxSpanLengthSegment(n) = calcMaxSpanLength(w_subm(n)*1000, installationSegmentMaxMoment(n));
end

 %Finding the maximum allowable span length out of all segments
[designMaxSpanLength, designMaxSpanLengthIndice] = min(designMaxSpanLengthSegment);
[designNoInternPMaxSpanLength, designNoInternPaxSpanLengthIndice] = min(desginNoInternPSpanlengthSegment);
[testMaxSpanLength, testMaxSpanLengthIndice] = min(testMaxSpanLengthSegment);
[testNoInternPMaxSpanLength, testNoInternPMaxSpanLengthIndice] = min(testNoInternPMaxSpanLengthSegment);
[installationMaxSpanLength, installationMaxSpanLengthIndice] = min(installationMaxSpanLengthSegment);

varNames = {'condition', 'Mcrit', 'McritOcc', 'Lmax', 'LmaxOcc'};
conditions = {'design', 'designNoP', 'test', 'testNoP', 'installation'};
critMoms = [criticalBendingMomentDesign, ...
    criticalBendingMomentDesignNoInternP, ...
    criticalBendingMomentTest, ...
    criticalBendingMomentTestNoInternP, ...
    criticalBendingMomentInstallation];
critMomOccs = [designCritMomIdx, designNoPCritMomIdx, testCritMomIdx, ...
    testNoPCritMomIdx, installCritMomIdx];
spanLengths = [designMaxSpanLength, designNoInternPMaxSpanLength, ...
    testMaxSpanLength, testNoInternPMaxSpanLength, ...
    installationMaxSpanLength];
spanLengthOccs = [designMaxSpanLengthIndice, ...
    designNoInternPaxSpanLengthIndice, testMaxSpanLengthIndice, ...
    testNoInternPMaxSpanLengthIndice, installationMaxSpanLengthIndice];

spanLengthResults = table(conditions(:), critMoms(:), critMomOccs(:), ...
    spanLengths(:), spanLengthOccs(:), 'VariableNames',   varNames)

function spanLength = calcMaxSpanLength(ws, maxMoment)
    spanLength = sqrt(12*(maxMoment/ws));
end