function formatted = combineTableColumns(integers, decimals)
integers = table2array(integers);
decimals = table2array(decimals);

maxValue = max(decimals);
if maxValue > 0
    logValue = log10(maxValue);
    logValue = ceil(logValue);
    decimals = decimals / 10^logValue;
end

formatted = array2table(integers + decimals);
end

