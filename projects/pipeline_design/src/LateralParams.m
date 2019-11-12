classdef LateralParams
    properties
        L  % significant wave parameter
        KC  % Keulegan-Carpenter number
        M  % Steady to oscillatory velocity ratio for design spectrum
        N  % Spectral acceleration factor
        tau  % Number of oscillations in the design bottom velocity spectrum
        Gs  % Soil (sand) density parameter
        Gc  % Soil (clay) density parameter
    end
    
  methods
        function obj = LateralParams(L,KC,M,N,tau,Gs,Gc)
            obj.L = L;
            obj.KC = KC;
            obj.M = M;
            obj.N = N;
            obj.tau = tau;
            obj.Gs = Gs;
            obj.Gc = Gc;
        end
    end
end

