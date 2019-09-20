classdef Pipeline
    properties
        designPressure
        testPressure
        tube
        flow
        groundConditions
        connections
    end
    methods
	    function obj = Pipeline(designPressure, testPressure, tube, flow, groundConditions, connections)
		    obj.designPressure = designPressure;
		    obj.testPressure = testPressure;
		    obj.tube = tube;
		    obj.flow = flow;
		    obj.groundConditions = groundConditions;
		    obj.connections = connections;
	    end
    end
end
