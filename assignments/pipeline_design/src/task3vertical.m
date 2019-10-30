segment = [1 2 3 4 5 6];

%t_steel = [0.0197 0.0196 0.0171 0.0197 0.0197 0.0197]; % design/test 
%gravity = 9.81; % m/s2 in main
% rhoSw = 1025; % kg/m3 in main
% rhoW = 1000; % kg/m3 in main

rhoG = 300; % kg/m3 
rho_corr = 1100; % kg/m3
rho_steel = 7850; % kg/m3
%Di = 0.4064; % m
Di = pipeSegments(1).getInnerDiameter();
t_conc = 0.045; % m
t_corr = 0.002; % m


for i= 1:length(pipeSegments)
    %t_s = t_steel(i);
    t_s = pipeSegments(i).calcT2(true);
    
    D(i) = Di + 2*t_s + 2*t_conc + 2*t_corr;
    
    buoyancy(i) = rhoSw*gravity*pi*D(i)^2/4;
    w_steel(i) = rho_steel*gravity*pi*(Di*t_s + t_s^2);
    w_corr(i) = rho_corr*gravity*pi*((Di+t_s)*t_corr + t_corr^2);
    
    % Minimum Concrete Density - kg/m3
    rho_conc(i) = (1.1*buoyancy(i) - w_steel(i) - w_corr(i)) / ...
       ( gravity*pi*((Di+t_s+t_corr)*t_conc + t_conc^2) );
    
    rho_c(i) = max(rho_conc(i), 2200);
    w_conc(i) = rho_c(i)*gravity*pi*((Di+t_s+t_corr)*t_conc + t_conc^2);
    w_water = rhoW*gravity*pi*Di^2/4;
    w_gas = rhoG*gravity*pi*Di^2/4;
   
    w_subm(i) = w_steel(i) + w_corr(i) + w_conc(i) - buoyancy (i); % criteria 0.1*buoyancy
    w_filled(i) = w_water + w_subm(i);
    w_fgas(i) = w_gas + w_subm(i);
    % Specific Gravity of pipe (water filled) N/m3
    SG_pipe(i) = w_filled(i) / (pi*D(i)^2/4);
   
end

w_subm = w_subm/1000; % kN/m
w_filled = w_filled/1000; % kN/m
w_fgas = w_fgas/1000; % kN/m
SG_pipe = SG_pipe/1000; % kN/m3

VarNames = {'Segment', 'Density', 'SG', 'SubW_empty', 'SubW_water', ...
    'SubW_gas'};
TableVerticalStability = table(segment(:),rho_conc(:),SG_pipe(:), w_subm(:), w_filled(:), ...
    w_fgas(:), 'VariableNames',VarNames)