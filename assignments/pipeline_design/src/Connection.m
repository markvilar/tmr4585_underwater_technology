classdef Connection
    properties
        submergedHeight
        locationClass
        safetyClass
    end
    methods
        function obj = Connection(submergedHeight, locationClass)
            obj.submergedHeight = submergedHeight;
            obj.locationClass = locationClass;
            obj.safetyClass = "";
        end
        function obj = calcSafetyClass(obj, fluidClass)
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
            end
        end
    end
end