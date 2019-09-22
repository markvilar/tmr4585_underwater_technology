classdef Connection
    properties
        submergedHeight
        distance
        offshore
        locationClass
        safetyClass
    end
    
    methods
        function obj = Connection(submergedHeight, distance, offshore, ...
                locationClass)
            obj.submergedHeight = submergedHeight;
            obj.distance = distance;
            obj.offshore = offshore;
            obj.locationClass = locationClass;
            obj.safetyClass = "";
        end
        function obj = setSafetyClass(obj, fluidClass)
            % Calculates the connection safety class according to 
            % DNV-OS-F101 table 2.2 and 2.4.
            % arg fluidClass: char
            if fluidClass == 'A' || fluidClass == 'C'
                if obj.locationClass == 1
                    obj.safetyClass = "low";
                elseif obj.locationClass == 2
                    obj.safetyClass = "medium";
                end
            elseif fluidClass == 'B' || fluidClass == 'D' || fluidClass == 'E'
                if obj.locationClass == 1
                    obj.safetyClass = "medium";
                elseif obj.locationClass == 2
                    obj.safetyClass = "high";
                end
            else
                obj.safetyClass = "";
            end
        end
    end
end