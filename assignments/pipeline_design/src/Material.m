classdef Material
    properties
        allowance
        tolerance
        density
        SMYS
        SMYT
        thermCon
        gammaM
    end
    
    methods
	    function obj = Material(allowance, tolerance, density, SMYS, SMYT, ...
                thermCon, gammaM)
            obj.allowance = allowance;
		    obj.tolerance = tolerance;
		    obj.density = density;
		    obj.SMYS = SMYS;
		    obj.SMYT = SMYT;
            obj.thermCon = thermCon;
            obj.gammaM = gammaM;
	    end
    end
end
