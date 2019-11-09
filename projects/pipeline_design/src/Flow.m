classdef Flow
    properties
        fluidClass
        inletTemperature
        velocity
        heatCapacity
        density
    end
    
    methods
	    function obj = Flow(fluidClass, inletTemperature, velocity, ...
                heatCapacity, density)
            obj.fluidClass = fluidClass;
            obj.inletTemperature = inletTemperature;
            obj.velocity = velocity;
		    obj.heatCapacity = heatCapacity;
            obj.density = density;
        end
        
        function fluidClass = getFluidClass(obj)
            fluidClass = obj.fluidClass;
        end
    end
end
