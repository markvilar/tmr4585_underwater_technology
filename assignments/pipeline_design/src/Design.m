classdef Design
    properties
        pipeline
        flow
        soil
        osSpectras
        isSpectras
        current
    end
    
    methods
	    function obj = Design(pipeline, flow, soil, osSpectras, ...
                isSpectras, current)
            obj.pipeline = pipeline;
            obj.flow = flow;
            obj.soil = soil;
            obj.osSpectras = osSpectras;
            obj.isSpectras = isSpectras;
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
