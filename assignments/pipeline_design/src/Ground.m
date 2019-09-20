classdef Ground
    properties
        frictionFactor
        dryWeight
        submergedWeight
        shearStrength
    end
    methods
        function obj = Ground(frictionFactor, dryWeight, submergedWeight, shearStrength)
		obj.frictionFactor = frictionFactor;
		obj.dryWeight = dryWeight;
		obj.submergedWeight = submergedWeight;
		obj.shearStrength = shearStrength;
	end
    end
end
