local analysis = {}

function analysis.netsum(transactions)
    sum = 0
    for key,transaction in pairs(transactions) do
        sum = sum + transaction.amount
    end
    return sum
end

function analysis.monthly_netsum(transactions)
    monthly = {}
    current_month = 0
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

return analysis
