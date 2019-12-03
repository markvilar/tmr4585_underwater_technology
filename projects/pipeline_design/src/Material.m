classdef Material
    properties
        tolerance % Fabricatioin tolerance
        density % Density
        SMYS % Specified minimum yield stress
        SMTS % Specified minimum tensile strength
        thermCon % Thermal conductivity
        gammaM % Material
        E % E-modulus
    end
    
    methods
	    function obj = Material(tolerance, density, SMYS, SMTS, ...
                thermCon, gammaM, E)
		    obj.tolerance = tolerance;
		    obj.density = density;
		    obj.SMYS = SMYS;
		    obj.SMTS = SMTS;
            obj.thermCon = thermCon;
            obj.gammaM = gammaM;
            obj.E = E;
	    end
    end
end
