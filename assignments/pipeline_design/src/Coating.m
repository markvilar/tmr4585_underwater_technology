classdef Coating
    properties
        thickness
        density
        thermCon
    end
    
    methods
        function obj = Coating(thickness, density, thermCon)
            obj.thickness = thickness;
            obj.density = density;
            obj.thermCon = thermCon;
        end
    end
end

