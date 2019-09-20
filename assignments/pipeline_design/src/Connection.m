classdef Connection
    properties
        submergedHeight
        locationClass
        safetyClass
    end
    methods
        function obj = Connection(submergedHeight, locationClass, safetyClass)
		obj.submergedHeight = submergedHeight;
		obj.locationClass = locationClass;
		obj.safetyClass = safetyClass;
	end
    end
end
