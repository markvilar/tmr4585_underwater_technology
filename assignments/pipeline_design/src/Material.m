classdef Material
    properties
        allowance
        tolerance
        density
        yield
        tensile
        thermCon
    end
    
    methods
	    function obj = Material(allowance, tolerance, density, yield, tensile, ...
                thermCon)
            obj.allowance = allowance;
		    obj.tolerance = tolerance;
		    obj.density = density;
		    obj.yield = yield;
		    obj.tensile = tensile;
            obj.thermCon = thermCon;
	    end
    end
end
