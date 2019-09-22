classdef Current
    properties
        returnPeriods;
        velocities;
    end
    
    methods
        function obj = Current(returnPeriods, velocities)
            if length(returnPeriods) ~= length(velocities)
                error("The number of return periods and current " + ...
                    "velocities must be the same.");
            end
        end
    end
end

