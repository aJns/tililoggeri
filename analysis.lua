local analysis = {}

function analysis.netsum(transactions)
    sum = 0
    for key,transaction in pairs(transactions) do
        sum = sum + transaction.amount
    end
    return sum
end

return analysis
