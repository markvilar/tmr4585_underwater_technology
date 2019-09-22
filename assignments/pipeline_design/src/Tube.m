classdef Tube
    properties
        insideDiameter
        ovality
        material
    end
    
    methods
        function obj = Tube(insideDiameter, ovality, material)
            obj.insideDiameter = insideDiameter;
            obj.ovality = ovality;
            obj.material = material;
        end
    end
end