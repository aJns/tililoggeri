local transaction_table = {}
local tablex = require "pl.tablex"

function transaction_table.init(trans_arg)
    transaction_table.transactions = tablex.deepcopy(trans_arg)
    transaction_table.years = {}
    sort_transactions()
    return transaction_table
end

function sort_transactions()
    local transactions = transaction_table.transactions
    for i, line in ipairs(transactions) do
        local year = line.date:year()
        local year_list = transaction_table.years[year]
        if year_list == nil then
            transaction_table.years[year] = {}
            transaction_table.years[year].transactions = {}
            year_list = transaction_table.years[year]
            year_list.months = {}
        end
        table.insert(year_list.transactions, line)
        year_list.sum = calculate_sum(year_list.transactions)

        local month = line.date:month()
        local month_list = transaction_table.years[year].months[month]
        if month_list == nil then
            transaction_table.years[year].months[month] = {}
            transaction_table.years[year].months[month].transactions = {}
            month_list = transaction_table.years[year].months[month]
            month_list.days = {}
        end
        table.insert(month_list.transactions, line)
        month_list.sum = calculate_sum(month_list.transactions)

        local day = line.date:day()
        local day_list = transaction_table.years[year].months[month].days[day]
        if day_list == nil then
            transaction_table.years[year].months[month].days[day]  = {}
            transaction_table.years[year].months[month].days[day].transactions = {}
            day_list = transaction_table.years[year].months[month].days[day]
        end
        table.insert(day_list.transactions, line)
        day_list.sum = calculate_sum(day_list.transactions)

    end
end

function calculate_sum(trans_arg)
    local sum = 0
    for i, transaction in pairs(trans_arg) do
        sum = sum + transaction.amount
    end
    return sum
end

function transaction_table.monthly_sums()
    local monthly = {}

    for year, year_table in pairs(transaction_table.years) do
        for month, month_table in pairs(year_table.months) do
            local sum = 0
            local month_key = ""
            if month < 10 then
                month_key = "0" .. month .. "-" .. year
            else
                month_key = month .. "-" .. year
            end
            sum = sum + month_table.sum
            monthly[month_key] = sum
        end
    end

    return monthly
end

return transaction_table
