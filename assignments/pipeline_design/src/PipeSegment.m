classdef PipeSegment
    properties
        startConn
        endConn
        insideDia
        ovality
        material
        locClass
        safeClass
    end
    
    methods
        function obj = PipeSegment(startConn, endConn, insideDia, ...
                ovality, material)
            if startConn.distance > endConn.distance
                temp = endConn;
                endConn = startConn;
                startConn = temp;
            end
            obj.startConn = startConn;
            obj.endConn = endConn;
            if (~startConn.offshore) || (~endConn.offshore)
                obj.locClass = 2;
            else
                obj.locClass = 1;
            end
            obj.insideDia = insideDia;
            obj.ovality = ovality;
            obj.material = material;
            obj.safeClass = "undefined";
        end
        
        function obj = setSafetyClass(obj, fluidClass)
            % Calculates the pipe segment safety class according to 
            % DNV-OS-F101 table 2-2 and 2-4.
            % arg fluidClass: char
            if fluidClass == 'A' || fluidClass == 'C'
                if obj.locClass == 1
                    obj.safeClass = "low";
                elseif obj.locClass == 2
                    obj.safeClass = "medium";
                end
            elseif fluidClass == 'B' || fluidClass == 'D' || fluidClass == 'E'
                if obj.locClass == 1
                    obj.safeClass = "medium";
                elseif obj.locClass == 2
                    obj.safeClass = "high";
                end
            else
                obj.safetyClass = "undefined";
            end
        end
        
        function [alphaMpt, alphaSpt] = getResistanceFactors(obj)
            % Returns the pipeline resistance factors based on the
            % safety class according to DNV-OS-F101 table 5-9.
            if strcmp(obj.safeClass, "low")
                alphaMpt = 1.000;
                alphaSpt = 1.03;
            elseif strcmp(obj.safeClass, "medium")
                alphaMpt = 1.088;
                alphaSpt = 1.05;
            elseif strcmp(obj.safeClass, "high")
                alphaMpt = 1.251;
                alphaSpt = 1.05;
            else
                error("Undefined pipe segment safety class.")
            end
        end
    end
end

