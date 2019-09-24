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
        
        function minDist = minDistToTargets(obj, frac, targets)
            [x, y] = obj.getXY(frac);
            n = length(targets);
            dists = zeros(1,n);
            for i = 1:length(targets)
                target = targets(i,:);
                xt = target(1);
                yt = target(2);
                dists(i) = sqrt((x-xt)^2 + (y-yt)^2);
            end
            minDist = min(dists);
        end
        
        function safeClass = getSafetyClass(~, locClass, fluidClass)
            if locClass == 1
                switch fluidClass
                    case {1,3}
                        safeClass = 1;
                    case {2,4,5}
                        safeClass = 2;
                    otherwise
                        safeClass = -1;
                end
            elseif locClass == 2
                switch fluidClass
                    case {1,3}
                        safeClass = 2;
                    case {2,4,5}
                        safeClass = 3;
                    otherwise
                        safeClass = -1;
                end
            else
                safeClass = -1;
            end
        end
        
        function [alphaMpt, alphaSpt] = getResistFactors(obj, dist, fluidClass)
            % Returns the pipeline resistance factors based on the
            % safety class according to DNV-OS-F101 table 5-9.
            if dist < 500 || (~obj.offshore)
                locClass = 2;
            else
                locClass = 1;
            end
            safeClass = obj.getSafetyClass(locClass, fluidClass);
            switch safeClass
                case 1
                    alphaMpt = 1.000;
                    alphaSpt = 1.03;
                case 2
                    alphaMpt = 1.088;
                    alphaSpt = 1.05;
                case 3
                    alphaMpt = 1.251;
                    alphaSpt = 1.05;
                otherwise
                    disp("Undefined pipe segment safety class, " ...
                        + "using the most conservative parameters.")
                    alphaMpt = 1.251;
                    alphaSpt = 1.05;
            end
        end
    end
end

