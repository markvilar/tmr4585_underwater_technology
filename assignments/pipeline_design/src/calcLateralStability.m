function [latParams] =  calcLateralStability(submergedWeight, rho_w, gravity, soil)
Us  % spectrally derived oscillatory velocity % FIND Us!!
Tu % mean zero up-crossing period of oscillating flow at pipe level.
D = Di %% FIND DIAMETER !!!
V = ??? %steady current velocity 
T = ???
drySoilWeight = soil.dryWeight;
submergedSoilWeight = soil.submergedWeight;
% Need to get submergedWeight of pipe!!

%s_u: un-drained clay shear strength
if inshore
    s_u = soil.inshoreShear;
else
    s_u = soil.offshoreShear;

%Compute Us and Tu for the entire pipe


%Calculate latparams:
L = sub_weight/(0.5*rho_w*D*Us^2);
KC = Us*Tu/D;
M=V/Us;
N = Us/(g*Tu);
tau = T/Tu;
Gs = submergedSoilWeight/(g*rho_w);
Gc = s_u/(D*drySoilWeight);
latParams = LateralParams(L,KC,M,N,tau,Gs,Gc);

end

