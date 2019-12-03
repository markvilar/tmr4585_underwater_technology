function [latParams] =  calcLateralStability(submergedWeight, rho_w, gravity, soil, segments,...
    t, osSpectras, isSpectras)
%Use worst case scenario: 100 year return period

%% Find dependencies:
%Us  spectrally derived oscillatory velocity % FIND Us!!
%Tu  mean zero up-crossing period of oscillating flow at pipe level.
Di = 0.4064; 
D = Di +2*t; %
z0 = 5*10^(-5);
V = 0.6 *( ((1+z0/D)*log(1+D/z0)) - 1 )/(log(1+5/z0)); %steady current velocity 
%T = ??? % nødvendig 
drySoilWeight = soil.dryWeight;
submergedSoilWeight = soil.submergedWeight;
g = gravity;
%s_u: un-drained clay shear strength


n = length(segments);
Tn_Tp= cell(n,1);
Tn_Hs= cell(n,1);

for i = 1:n
    if n < 4 %offshore 
      s_u = soil.offshoreShear;
      % need Hs and Tp  
      Hs = osSpectras.waveHeights(3); % for year = 100 
      Tp = osSpectras.peakPeriods(3);
    else %inshor
        s_u = soil.inshoreShear; 
        Hs = isSpectras.waveHeights(3); % for year = 100 
        Tp = isSpectras.peakPeriods(3);
    end
    % get submerged weight  !!!!! regn ut selv eller hør med Anders
    
    % find Hs, Tp, and Tn:
    nSample = nSamples(i);
    segment = segments(i);
    Tn = zeros(nSample,1);
    for j = 1:nSample
        frac = (j-1)*(1/(nSample-1));
        [~, y] = segment.getXY(frac);
        Tn(j) = sqrt(y/g); % y = d is depth
    end
    Tn_Tp{i} = Tn/Tp; 
    Tn_Tp{i} = Tn/Hs;
end

%Compute Us and Tu for the entire pipe: use figure 3-2 

%% Calculate latparams:
% Initialize parameters as vecotrs. Ech element is a segment part.
L = zeros(1,n);   
KC  = zeros(1,n); 
M = zeros(1,n);
N = zeros(1,n);
tau = zeros(1,n);
Gs = zeros(1,n);
Gc = zeros(1,n);

L(:) = submergedWeight/(0.5*rho_w*D*Us^2);
KC(:) = Us*Tu/D;
M(:)=V/Us;
N(:) = Us/(g*Tu);
tau = T/Tu;
Gs(:) = submergedSoilWeight/(g*rho_w);
Gc(:) = s_u/(D*drySoilWeight);

latParams = LateralParams(L,KC,M,N,tau,Gs,Gc);

end

