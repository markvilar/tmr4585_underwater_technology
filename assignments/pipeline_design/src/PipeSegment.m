classdef PipeSegment
    properties
        startConn
        endConn
        isOffshore
        innerD
        t
        ovality
        material
        corrCoat
        concCoat
        isRiser
    end
    
    methods
        function obj = PipeSegment(startConn, endConn, isOffshore, ...
                innerD, ovality, material, corrCoat, concCoat, isRiser)
            obj.startConn = startConn;
            obj.endConn = endConn;
            obj.isOffshore = isOffshore;
            obj.innerD = innerD;
            obj.ovality = ovality;
            obj.material = material;
            obj.corrCoat = corrCoat;
            obj.concCoat = concCoat;
            obj.isRiser = isRiser;
            obj.t = -1;
        end
        
        function obj = setT(obj, t)
            if t <= 0
                error("Wall thickness cannot be zero or negative.")
            end
            obj.t = t;
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
        
        function minHDist = minHDistToTargets(obj, frac, targets)
            [x, y] = obj.getXY(frac);
            n = length(targets);
            hDists = zeros(1,n);
            for i = 1:length(targets)
                target = targets(i,:);
                xt = target(1);
                hDists(i) = abs(xt-x);
            end
            minHDist = min(hDists);
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
        
        function [alphaMpt, alphaSpt, gammas] = getResistFactors(obj, hDist, fluidClass)
            % Returns the pipeline resistance factors based on the
            % safety class according to DNV-OS-F101 table 5-9.
            % arg hDist: float
            % arg fluidClass: int
            if hDist < 500 || (~obj.isOffshore)
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
            gammas = 2*alphaMpt/(0.96*sqrt(3)); % Eq. from table 5-9
        end
        
        function D = calcDiameter(obj)
            tCorr = obj.corrCoat.getThickness();
            tConc = obj.concCoat.getThickness();
            D = obj.innerD + 2*obj.t + 2*tCorr + 2*tConc;
        end
    end
end

