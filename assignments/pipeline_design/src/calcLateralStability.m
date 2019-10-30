function [latParams] =  calcLateralStability(submergedWeight, rho_w, gravity, soil, segments, t)

%% Find dependencies:
Us  % spectrally derived oscillatory velocity % FIND Us!!
Tu % mean zero up-crossing period of oscillating flow at pipe level.
Di = 0.4064; 
D = Di +2*t; %
V = ??? %steady current velocity 
T = ???  % peiod of wave -- SPØR SVEIN!
drySoilWeight = soil.dryWeight;
submergedSoilWeight = soil.submergedWeight;
g = gravity;


%s_u: un-drained clay shear strength
if inshore
    s_u = soil.inshoreShear;
else
    s_u = soil.offshoreShear;
end

n = length(segments);
for i = 1:n
    % get submerged weight  !!!!! regn ut selv eller hør med Anders
    %Compute Us and Tu for the entire pipe
    Tn = sqrt(d/g); %d is depth
end

%% Calculate latparams:
% Initialize parameters as vecotrs. Ech element is a segment part.
L = zeros(1,n);   
KC  = zeros(1,n); 
M = zeros(1,n);
N = zeros(1,n);
tau = zeros(1,n);
Gs = zeros(1,n);
Gc = zeros(1,n);

L = submergedWeight/(0.5*rho_w*D*Us^2);
KC = Us*Tu/D;
M=V/Us;
N = Us/(g*Tu);
tau = T/Tu;
Gs = submergedSoilWeight/(g*rho_w);
Gc = s_u/(D*drySoilWeight);

latParams = LateralParams(L,KC,M,N,tau,Gs,Gc);

end

