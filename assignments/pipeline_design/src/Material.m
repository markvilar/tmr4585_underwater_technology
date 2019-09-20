classdef Material
    properties
        tolerance
        density
        yieldStress
        tensileStrength
    end
    methods
	    function obj = Material(tolerance, density, yieldStress, tensileStrength)
		    obj.tolerance = tolerance;
		    obj.density = density;
		    obj.yieldStress = yieldStress;
		    obj.tensileStrength = tensileStrength;
	    end
    end
end
