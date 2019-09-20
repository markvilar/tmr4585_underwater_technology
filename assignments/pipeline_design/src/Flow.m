classdef Flow
    properties
        fluidClass
        inletTemperature
        velocity
        heatCapacity
        density
    end
    methods
	    function obj = Flow(class, temperature, velocity, heatCapacity, density)
		    obj.fluidClass = class;
		    obj.inletTemperature = temperature;
		    obj.velocity = velocity;
		    obj.heatCapacity = heatCapacity;
		    obj.density = density;
    end
end
