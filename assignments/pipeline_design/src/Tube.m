classdef Tube
    properties
        insideDiameter
        ovality
    end
    methods
        function obj = Tube(insideDiameter, ovality)
            obj.insideDiameter = insideDiameter;
            obj.ovality = ovality;
        end
    end
end