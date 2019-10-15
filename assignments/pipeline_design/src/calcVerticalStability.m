function results = calcVerticalStability(segments, soil, rhoIMax, rhoIMin)

nSegs = length(segments);
outerDs = zeros(nSegs, 1);
for n = 1:nSegs
   outerDs(n) = segments(n).calcDiameter();
end

end