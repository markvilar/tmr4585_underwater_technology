function maxDesignMoments = calcMaxDesignMoment(segments, flow, targets, Po, ...
    rhoE, rhoI, g, Pref, yref, nSamples, t_2)
% Calculates the most conservative maximum allowable free span length
% DNV-OS-F101 section 5D.
% arg segments: Nx1 array of PipeSegment objects
% arg flow: Flow object
% arg targets: Mx2 array, human locations
% arg po: float, atmospheric pressure
% arg rhoE: float, sea water density
% arg rhoI: float, internal fluid density
% arg g: float, gravitational acceleration
% arg Pref: float, reference pressure
% arg yref: float, reference height
% arg Ks: Kx1 array of ints, number of sample points along each segment
% return: cell array of vectors, the minimum thicknesses along each segment
assert(length(segments) == length(nSamples), "Number of segments and amount " ...
    + "sample points must be the same.");
fluidClass = flow.getFluidClass();
N = length(segments);
maxDesignMoments = cell(N,1);
for i = 1:N
    nSample = nSamples(i);
    maxDesignMoment = zeros(nSample,1);
    segment = segments(i);
    [SMYS, SMYT] = segment.getMaterialStrength();
    alpha_U = 0.96; %Material strength factor. Table 5.4 
    fy_temp = 0;
    fu_temp = 0;
    fy = (SMYS - fy_temp)*alpha_U;
    fu = (SMYT - fu_temp)*alpha_U;
    fcb = min([fy, fu/1.15]); % Equation 5.9
    Di = segment.getInnerDiameter();
    D = Di + t_2; %Assumes that the nominal diameter is the inner plus 
                    %wall thickness
    
    beta = betaCalc(D,t_2);              
    alpha_c = alpha_cCalc(beta,fu,fy);
    Mp = MpCalc(fy,D,t_2);
    Pb = p_bCalc(t_2,D,fcb);
    
    %Calculating 
    for j = 1:nSample
        frac = (j-1)*(1/(nSample-1));
        [x, y] = segment.getXY(frac);
        hDdist = segment.minHDistToTargets(frac, targets);
        [alphaMpt, alphaSpt, gammas] = segment.getResistFactors(hDdist, ...
            fluidClass);
        Pe = Po - rhoE*g*min(y, 0);    % External pressure
        Pi = Pref - rhoI*g*(y - yref); % Internal pressure
        alpha_p = alpha_pCalc(beta,Pi,Pe,Pb);
        maxDesignMoment(j) = ((alpha_c*Mp)/(gammas))*sqrt(1-(alpha_p*((Pi-Pe)/(alpha_c*Pb)))^2); %Eq 5.19, solved for design moment
        
    end
    maxDesignMoments{i} = maxDesignMoment;
end
end


function plasticCapaMoment = MpCalc(fy,D,t)
    plasticCapaMoment = fy*pi*(D-t)*t;
end

function flowStressPar = alpha_cCalc(beta,fu,fy)
    flowStressPar = (1-beta) + beta*(fu/fy);
end

function a_p = alpha_pCalc(beta,Pi,Pe,Pb)
    rel = (Pi-Pe)/Pb;
    if rel < (2/3)
        a_p = (1 - beta);
    else
        a_p = 1 - (3*beta*(1-rel));
    end
end

function pressureContRes = p_bCalc(t,D,fcb)
    pressureContRes = ((2*t)/(D-t))*fcb*(2/sqrt(3));
end

function betaRes = betaCalc(D,t_2)
    betaRes = (60-(D/t_2))/(90);
end


