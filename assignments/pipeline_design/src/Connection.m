classdef Connection
    properties
        subHeight
        distance
        offshore
    end
    
    methods
        function obj = Connection(subHeight, distance, offshore)
            obj.subHeight = subHeight;
            obj.distance = distance;
            obj.offshore = offshore;
        end
    end
end