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
        year_list.revenue = calculate_revenue(year_list.transactions)
        year_list.expenses = calculate_expenses(year_list.transactions)

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
        month_list.revenue = calculate_revenue(month_list.transactions)
        month_list.expenses = calculate_expenses(month_list.transactions)

        local day = line.date:day()
        local day_list = transaction_table.years[year].months[month].days[day]
        if day_list == nil then
            transaction_table.years[year].months[month].days[day]  = {}
            transaction_table.years[year].months[month].days[day].transactions = {}
            day_list = transaction_table.years[year].months[month].days[day]
        end
        table.insert(day_list.transactions, line)
        day_list.sum = calculate_sum(day_list.transactions)
        day_list.revenue = calculate_revenue(day_list.transactions)
        day_list.expenses = calculate_expenses(day_list.transactions)
    end
end

function calculate_sum(trans_arg)
    local sum = 0
    for i, transaction in pairs(trans_arg) do
        sum = sum + transaction.amount
    end
    return sum
end

function calculate_revenue(trans_arg)
    local revenue = 0
    for i, transaction in pairs(trans_arg) do
        if (revenue > 0) then
            revenue = revenue + transaction.amount
        end
    end
    return revenue
end

function calculate_expenses(trans_arg)
    local expenses = 0
    for i, transaction in pairs(trans_arg) do
        if (expenses < 0) then
            expenses = expenses + transaction.amount
        end
    end
    return revenue
end

function transaction_table.yearly_sums()
    local yearly = {}

    for year, year_table in pairs(transaction_table.years) do
        sum_table = {}
        local sum = 0
        local year_key = ""
        year_key = year
        sum = sum + year_table.sum
        sum_table.sum = sum
        sum_table.year_key = year_key
        table.insert(yearly, sum_table)
    end

    return yearly
end

function transaction_table.monthly_sums()
    local monthly = {}

    for year, year_table in pairs(transaction_table.years) do
        for month, month_table in pairs(year_table.months) do
            sum_table = {}
            local sum = 0
            local month_key = ""
            if month < 10 then
                month_key = "0" .. month .. "-" .. year
            else
                month_key = month .. "-" .. year
            end
            sum = sum + month_table.sum
            sum_table.sum = sum
            sum_table.month_key = month_key
            table.insert(monthly, sum_table)
        end
    end

    return monthly
end

function transaction_table.daily_sums()
    local daily = {}

    for year, year_table in pairs(transaction_table.years) do
        for month, month_table in pairs(year_table.months) do
            sum_table = {}
            local month_key = ""
            if month < 10 then
                month_key = "0" .. month .. "-" .. year
            else
                month_key = month .. "-" .. year
            end
            for day, day_table in pairs(month_table.days) do
                local sum = 0
                local day_key = ""
                if day < 10 then
                    day_key = "0" .. day .. "-" .. month_key
                else
                    day_key = day .. "-" .. month_key
                end
                sum = sum + day_table.sum
                sum_table.sum = sum
                sum_table.day_key = day_key
                table.insert(daily, sum_table)
            end
        end
    end

    return daily
end

return transaction_table
