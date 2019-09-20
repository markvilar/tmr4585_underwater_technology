classdef Pipeline
    properties
        designPressure
        testPressure
        flow
        tubes
        groundConditions
        connections
    end
    methods
	    function obj = Pipeline(designPressure, testPressure, flow, tubes, groundConditions, connections)
		    obj.designPressure = designPressure;
		    obj.testPressure = testPressure;
            obj.flow = flow;
		    obj.tubes = tubes;
		    obj.groundConditions = groundConditions;
		    obj.connections = connections;
        end
        function calcSafetyClasses(obj)
            fluidClass = obj.flow.fluidClass;
            n = length(obj.connections);
            for i = 1:n
                connection = obj.connections(i);
                
            end
        end
        function burstingResults = burstingCriterion(obj)
            
        end
        function bucklingResults = bucklingCriterion(obj)
            
        end
        function vStabilityResults = vStabilityCriterion(obj)
            
        end
        function hStabilityResults = hStabilityCriterion(obj)
            
        end
    end
end
