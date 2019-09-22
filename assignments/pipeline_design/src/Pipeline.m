classdef Pipeline
    properties
        designPressure
        testPressure
        incidentPressure
        flow
        tube
        connections
        soil
        offshoreSpectras
        inshoreSpectras
        current
    end
    
    methods
	    function obj = Pipeline(designPressure, testPressure, ...
                incidentPressure, flow, tube, connections, soil, ...
                offshoreSpectras, inshoreSpectras, current)
		    obj.designPressure = designPressure;
		    obj.testPressure = testPressure;
            obj.incidentPressure = incidentPressure;
            obj.flow = flow;
		    obj.tube = tube;
		    obj.connections = connections;
            obj.soil = soil;
            obj.offshoreSpectras = offshoreSpectras;
            obj.inshoreSpectras = inshoreSpectras;
            obj.current = current;
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
