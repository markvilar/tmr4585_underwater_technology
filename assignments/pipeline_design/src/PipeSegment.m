classdef PipeSegment
    properties
        startConn
        endConn
        offshore
        innerD
        ovality
        material
        corrCoat
    end
    
    methods
        function obj = PipeSegment(startConn, endConn, offshore, ...
                innerD, ovality, material, corrCoat)
            obj.startConn = startConn;
            obj.endConn = endConn;
            obj.offshore = offshore;
            obj.innerD = innerD;
            obj.ovality = ovality;
            obj.material = material;
            obj.corrCoat = corrCoat;
        end
        
        function [x, y] = getXY(obj, frac)
            if frac < 0
                frac = 0;
            elseif frac > 1
                frac = 1;
            end
            [xa, ya] = obj.startConn.getXY();
            [xb, yb] = obj.endConn.getXY();
            delX = xb - xa;
            delY = yb - ya;
            x = xa + frac*delX;
            y = ya + frac*delY;
        end
        
        function mat = getMaterial(obj)
            mat = obj.material;
        end
        
        function [fy, fu] = getMaterialStrength(obj)
            fy = obj.material.yield;
            fu = obj.material.tensile;
        end
        
        function d = getInnerDiameter(obj)
            d = obj.innerD;
        end
        
        function [alphaMpt, alphaSpt] = getResistanceFactors(obj)
            % Returns the pipeline resistance factors based on the
            % safety class according to DNV-OS-F101 table 5-9.
            switch obj.safeClass
                case "low"
                    alphaMpt = 1.000;
                    alphaSpt = 1.03;
                case "medium"
                    alphaMpt = 1.088;
                    alphaSpt = 1.05;
                case "high"
                    alphaMpt = 1.251;
                    alphaSpt = 1.05;
                otherwise
                    disp("Undefined pipe segment safety class.")
                    alphaMpt = 1.251;
                    alphaSpt = 1.05;
            end
        end
    end
end

