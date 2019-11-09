classdef Connection
    properties
        x
        y
    end
    
    methods
        function obj = Connection(x, y)
            obj.x = x;
            obj.y = y;
        end
        
        function [x, y] = getXY(obj)
            x = obj.x;
            y = obj.y;
        end
    end
end

