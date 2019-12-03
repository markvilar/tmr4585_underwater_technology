%% Minimum required bottom tension and horizontal radius of curvature
Esteel = 200*10^9;
Econc = 17*10^9;
McrInstall = installationSegmentMaxMoment;
wsInstall = w_subm * 1000;
theta = 0;

[T0s, Rmins, Isteel, Iconc] = calcCatenary(pipeSegments, soil, ...
    wsInstall, McrInstall, Esteel, Econc, theta);

segments = [1, 2, 3, 4, 5, 6];
varNames = {'Segment', 'Isteel', 'Iconc', 'T0', 'Rmin'};
catenaryResults = table(segments(:), Isteel(:), Iconc(:), T0s(:), ...
    Rmins(:), 'VariableNames', varNames)