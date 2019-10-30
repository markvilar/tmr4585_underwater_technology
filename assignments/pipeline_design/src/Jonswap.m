classdef Jonswap
    properties
        returnPeriods;
        waveHeights;
        peakPeriods;
        spectrum;
    end
    
    methods
        function obj = Jonswap(returnPeriods, waveHeights, peakPeriods)
            if length(returnPeriods) ~= length(waveHeights) || ...
                    length(waveHeights) ~= length(peakPeriods)
                error("The number of return periods, significant " ...
                    + "wave heigths and peak periods must be equal.")
            else
                obj.returnPeriods = returnPeriods;
                obj.waveHeights = waveHeights;
                obj.peakPeriods = peakPeriods;
               
            end
        end
    end
end