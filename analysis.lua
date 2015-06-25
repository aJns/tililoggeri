local analysis = {}

function analysis.netsum(transactions)
    local sum = 0
    for key,transaction in pairs(transactions) do
        sum = sum + transaction.amount
    end
    return sum
end

function analysis.monthly_netsum(transactions)
    local monthly = {}
    local current_month = 0
    for key,transaction in ipairs(transactions) do
        if transaction.date:month() < 10 then
            month = "0" .. transaction.date:month() .. "-" .. transaction.date:year()
        else
            month = transaction.date:month() .. "-" .. transaction.date:year()
        end
        if current_month == month then
            temp_sum = monthly[month] 
            temp_sum = temp_sum + transaction.amount
            monthly[month] = temp_sum
        else
            monthly[month] = 0
            current_month = month
        end
    end

    return monthly
end

function analysis.median_monthly_netsum(transactions)
    local monthly = analysis.monthly_netsum(transactions)
    while require "pl.tablex".size(monthly) > 3 do
        local highest = 0
        local lowest = 0
        local hKey = ""
        local lKey = ""
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
        monthly[hKey] = nil
        monthly[lKey] = nil
    end
    return monthly
end

return analysis
