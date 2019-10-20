classdef Material
    properties
        allowance
        tolerance
        density
        SMYS
        SMYT
        thermCon
    end
    
    methods
	    function obj = Material(allowance, tolerance, density, SMYS, SMYT, ...
                thermCon)
            obj.allowance = allowance;
		    obj.tolerance = tolerance;
		    obj.density = density;
		    obj.SMYS = SMYS;
		    obj.SMYT = SMYT;
            obj.thermCon = thermCon;
	    end
    end
end
