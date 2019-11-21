function [latLengths, longLengths] = WGS84NorthEast(latitudes, longitudes)
% Calculates the latitude and longitude length based on the latitude and
% longitude based on the WGS84 spheroid.
assert(length(latitudes) == length(longitude), ...
    'Number of latitudes and longitudes must be the same.');

n = length(latitudes);
latLengths = zeros(n,1);
longLengths = zeros(n,1);

for i = 1:length(latitudes)
    long
end
end

