function interpolated = interpolateCells(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
interpolated = cell(size(x));
N = length(x);

for n = 1:N
    y = x{n};
    if isempty(y)
        if n == 1
            for j = n+1:N % Look forwards in cell array
                z = x{j};
                if ~isempty(z)
                    y = z;
                    break;
                end
            end
        elseif n == N
            for j = n-1:-1:1 % Look backwards in cell array
                z = x{j};
                if ~isempty(z)
                    y = z;
                    break;
                end
            end
        else
            for j = n+1:N % Look forwards in cell array
                z = x{j};
                if ~isempty(z)
                    f = z;
                    break;
                end
            end
            for j = n-1:-1:1 % Look backwards in cell array
                z = x{j};
                if ~isempty(z)
                    b = z;
                    break;
                end
            end
            y = mean([f; b], 1);
        end
    end
    interpolated{n} = y;
end
end

