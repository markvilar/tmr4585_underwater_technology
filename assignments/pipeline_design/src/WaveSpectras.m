classdef WaveSpectras
    properties
        allYear
        spring
        summer
        autumn
        winter
    end
    
    methods
        function obj = WaveSpectras(allYear, spring, summer, autumn, winter)
            obj.allYear = allYear;
            obj.spring = spring;
            obj.summer = summer;
            obj.autumn = autumn;
            obj.winter = winter;
        end
    end
end

