%% The most conservative maximum allowable free span
nSamples = [20, 10, 10, 10, 10, 20];

maxMoment = 0.0197;
t_corr = 0.002;
t_2_prior_operation = maxMoment + t_corr;
t_2_operation = maxMoment;

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
installationSegmentMaxMoment = zeros(nSegs, 1);

%maxSegmentOverallMoment = zeros(nSegs, 1);
%For each segment, get the max moment from the samples
for n = 1:nSegs
    designSegmentSamplesM = MaxDesignMomentSegments{n};
    designNoInternPSegmentSamplesM = MaxDesignMomentSegmentsNoInternP{n};
    testSegmentSamplesM = MaxTestMomentSegments{n};
    installSegmentSamplesM = MaxInstallationMomentSegments{n};
    designSegmentMaxMoment(n) = max(designSegmentSamplesM);
    designNoInternPSegmentMaxMoment(n) = max(designNoInternPSegmentSamplesM);
    testSegmentMaxMoment(n) = max(testSegmentSamplesM);
    installationSegmentMaxMoment(n) = max(installSegmentSamplesM);
end

%Finding the maximum moment out of all segments
[designMaxMoment, designMaxMomentIndice] = max(designSegmentMaxMoment);
[designNoInternPMaxMoment, designNoInternPMaxMomentIndice] = max(designNoInternPSegmentMaxMoment);
[testMaxMoment, testMaxMomentIndice] = max(testSegmentMaxMoment);
[installationMaxMoment, installationMaxMomentIndice] = max(installationSegmentMaxMoment);

%Finding submerged weight at the segment of where the maximum moment is
wsDesignSegment = w_fgas(designMaxMomentIndice)*1000;   %Gas filled pipe
wsDesignNoInternPSegment = w_subm(designNoInternPMaxMomentIndice)*1000; %empty pipe
wsTestSegment = w_filled(testMaxMomentIndice)*1000;     %Water filled pipe
wsInstallationMaxMoment = w_subm(installationMaxMomentIndice)*1000; %Empty pipe

%Calculating the maximum allowable spanning length
designMaxSpanlength = calcMaxSpanLength(wsDesignSegment,designMaxMoment)
desginNoInternPSpanlength = calcMaxSpanLength(wsDesignNoInternPSegment,designNoInternPMaxMoment)
testMaxSpanLength = calcMaxSpanLength(wsTestSegment,testMaxMoment)
installationMaxSpanLength = calcMaxSpanLength(wsInstallationMaxMoment, installationMaxMoment)



function spanLength = calcMaxSpanLength(ws, maxMoment)
    spanLength = sqrt(12*(maxMoment/ws));
end
