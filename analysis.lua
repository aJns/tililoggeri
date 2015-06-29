local analysis = {}
local tablex = require "pl.tablex"

function analysis.netsum(transactions)
    local sum = 0
    for key,transaction in pairs(transactions) do
        sum = sum + transaction.amount
    end
    return tonumber(string.format("%.2f", sum))
end

function analysis.median_monthly_netsum(trans_table)
    local monthly = trans_table.monthly_sums()
    remove_monthly_extremes(monthly, (tablex.size(monthly) - 1) / 2)
    local median = 0
    for month, sum in pairs(monthly) do
        median = median + sum
    end
    median = median / tablex.size(monthly)
    return median
end

function analysis.average_monthly_netsum(trans_table)
    local monthly = trans_table.monthly_sums()
    local average = 0
    for month, sum in pairs(monthly) do
        average = average + sum
    end
    average = average / tablex.size(monthly)
    return tonumber(string.format("%.2f", average))
end

function remove_monthly_extremes(monthly, remove_count)
    --The amount specified by remove_count is removed at each end of the list
    local remove = remove_count
    for i=1, remove, 1 do
        --Gets a random key from monthly
        start_key = tablex.keys(monthly)[1]
        local highest = monthly[start_key]
        local lowest = monthly[start_key]
        local hKey = start_key
        local lKey = start_key
        for month, sum in pairs(monthly) do
            if sum > highest then
                highest = sum
                hKey = month
            end
            if sum < lowest then
                lowest = sum
                lKey = month
            end
        end
        if tablex.size(monthly) > 1 then
            monthly[hKey] = nil
            --Make sure that monthly is not completely emptied in any case
            if tablex.size(monthly) > 1 then
                monthly[lKey] = nil
            end
        end
    end
end

return analysis
