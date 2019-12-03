function [colors, minValue, maxValue] = createRedBlueMap(x, g)
% arg x: Nx1 array
if nargin < 2
    g = 0;
end

N = size(x, 1);
colors = zeros(N, 3);
colors(:, 2) = g;
minValue = min(x); % Blue
maxValue = max(x); % Red

for n = 1:N
    frac = (x(n) - minValue) / (maxValue - minValue);
    r = frac;
    b = 1 - frac;
    colors(n, 1) = r;
    colors(n, 3) = b;
end
end