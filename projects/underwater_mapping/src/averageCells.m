function averaged = averageCells(x)
averaged = cell(size(x));

for i = 1:length(x)
    y = x{i};
    if ~isempty(y)
        y = mean(y, 1);
    end
    averaged{i} = y;
end
end