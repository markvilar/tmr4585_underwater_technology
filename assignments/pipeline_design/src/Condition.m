classdef Condition
    properties
        pressure
        reference
        density
        gravity
    end
    
    methods
        function obj = Condition(pressure, reference, density, gravity)
            obj.pressure = pressure;
            obj.reference = reference;
            obj.density = density;
            obj.gravity = gravity;
        end
    end
end

