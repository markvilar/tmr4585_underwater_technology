classdef Pipeline
    properties
        designCon
        testCon
        installCon
        segments
    end
    
    methods
        function obj = Pipeline(designCon, testCon, installCon, segments)
            obj.designCon = designCon;
            obj.testCon = testCon;
            obj.installCon = installCon;
            obj.segments = segments;
        end
    end
end