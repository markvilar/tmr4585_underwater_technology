classdef Soil
    properties
        friction
        dryWeight
        submergedWeight
        offshoreShear
        inshoreShear
    end
    
    methods
        function obj = Soil(friction, dryWeight, submergedWeight, ...
                offshoreShear, inshoreShear)
            obj.friction = friction;
            obj.dryWeight = dryWeight;
            obj.submergedWeight = submergedWeight;
            obj.offshoreShear = offshoreShear;
            obj.inshoreShear = offshoreShear;
        end
    end
end
