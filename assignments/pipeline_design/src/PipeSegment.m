classdef PipeSegment
    properties
        startConn
        endConn
        locClass % Location class, 1 = low, 2 = medium, 3 = high
        Di % Pipe wall inner diameter
        t % Pipe wall thickness
        ovality % Pipe wall ovality
        material % Pipe wall material
        tCorr % Corrosion coating thickness
        rhoCorr % Corrosion coating density
        kCorr % Corrosion coating thermal conductivity
        tConcMin % Minimum concrete thickness
        tConc % Concrete thickness
        rhoConc % Concrete density
        kConc % Concrete thermal conductivity
        gammaSC % Safety class resistance factor
    end
    
    methods
        function obj = PipeSegment(startConn, endConn, locClass, ...
                Di, ovality, material, tCorr, rhoCorr, kCorr, ...
                tConcMin, rhoConc, kConc)
            obj.startConn = startConn;
            obj.endConn = endConn;
            obj.locClass = locClass;
            obj.Di = Di;
            obj.t = -1;
            obj.ovality = ovality;
            obj.material = material;      
            obj.tCorr = tCorr;
            obj.rhoCorr = rhoCorr;
            obj.kCorr = kCorr;
            obj.tConcMin = tConcMin;
            obj.tConc = -1;
            obj.rhoConc = rhoConc;
            obj.kConc = kConc;
        end
        
        function mat = getMaterial(obj)
            mat = obj.material;
        end
        
        function [fy, fu] = getMaterialStrength(obj)
            fy = obj.material.SMYS;
            fu = obj.material.SMYT;
        end
        
        function d = getInnerDiameter(obj)
            d = obj.Di;
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
        
        function safeClass = getSafetyClass(obj, fluidClass)
            % Definition from table 2-4.
            % arg fluidClass: int, 1-5
            if obj.locClass == 1
                switch fluidClass
                    case {1,3}
                        safeClass = 1;
                    case {2,4,5}
                        safeClass = 2;
                    otherwise
                        safeClass = -1;
                end
            elseif obj.locClass == 2
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
        
        function [gammaM, gammaSC] = getResistFactors(obj, fluidClass)
            % Returns the pipeline resistance factors based on the
            % safety class according to DNV-OS-F101 table 5-9.
            % arg fluidClass: int
            safeClass = obj.getSafetyClass(fluidClass);
            switch safeClass
                case 1
                    gammaSC = 1.046;
                case 2
                    gammaSC = 1.138;
                case 3
                    gammaSC = 1.308;
                otherwise
                    gammaSC = 1.308;
            end
            gammaM = obj.material.gammaM;
        end
        
        function obj = setTFromT1(obj, t1)
            if t1 <= 0
                error("t1 cannot be zero or negative.")
            end
            obj.t = (1/(1-obj.material.tolerance))*(t1 + obj.tCorr);
        end
        
        function t1 = calcT1(obj, operational)
            % Returns characteristic wall thickness as defined in table 5-6
            % arg operational: boolean
            tFab = obj.material.tolerance * obj.t;
            if operational
                t1 = obj.t-tFab-obj.tCorr;
            else
                t1 = obj.t-tFab;
            end
        end
        
        function t2 = calcT2(obj, operational)
            % Returns characteristic wall thickness as defined in table 5-6
            % arg operational: boolean
            if operational
                t2 = obj.t - obj.tCorr;
            else
                t2 = obj.t;
            end
        end
    end
end

