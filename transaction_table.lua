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
        local amount = tonumber(transaction.amount)
        if (amount > 0) then
            revenue = revenue + transaction.amount
        end
    end
    return revenue
end

function calculate_expenses(trans_arg)
    local expenses = 0
    for i, transaction in pairs(trans_arg) do
        local amount = tonumber(transaction.amount)
        if (amount < 0) then
            expenses = expenses + transaction.amount
        end
    end
    return expenses
end

-- Sum functions: Calculate the net sum of years, months and days and return
-- a list containing them and a date
function transaction_table.yearly_sums()
    local yearly = {}

    for year, year_table in pairs(transaction_table.years) do
        local sum_table = {}
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
            local sum_table = {}
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
            local month_key = ""
            if month < 10 then
                month_key = "0" .. month .. "-" .. year
            else
                month_key = month .. "-" .. year
            end
            for day, day_table in pairs(month_table.days) do
                local sum_table = {}
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
-- sum functions

-- Revenue functions: Calculate the net revenue of years, months and days and 
-- return a list containing them and a date
function transaction_table.yearly_revenues()
    local yearly = {}

    for year, year_table in pairs(transaction_table.years) do
        local revenue_table = {}
        local revenue = 0
        local year_key = ""
        year_key = year
        revenue = revenue + year_table.revenue
        revenue_table.revenue = revenue
        revenue_table.year_key = year_key
        table.insert(yearly, revenue_table)
    end

    return yearly
end

function transaction_table.monthly_revenues()
    local monthly = {}

    for year, year_table in pairs(transaction_table.years) do
        for month, month_table in pairs(year_table.months) do
            local revenue_table = {}
            local revenue = 0
            local month_key = ""
            if month < 10 then
                month_key = "0" .. month .. "-" .. year
            else
                month_key = month .. "-" .. year
            end
            revenue = revenue + month_table.revenue
            revenue_table.revenue = revenue
            revenue_table.month_key = month_key
            table.insert(monthly, revenue_table)
        end
    end

    return monthly
end

function transaction_table.daily_revenues()
    local daily = {}

    for year, year_table in pairs(transaction_table.years) do
        for month, month_table in pairs(year_table.months) do
            local month_key = ""
            if month < 10 then
                month_key = "0" .. month .. "-" .. year
            else
                month_key = month .. "-" .. year
            end
            for day, day_table in pairs(month_table.days) do
                local revenue_table = {}
                local revenue = 0
                local day_key = ""
                if day < 10 then
                    day_key = "0" .. day .. "-" .. month_key
                else
                    day_key = day .. "-" .. month_key
                end
                revenue = revenue + day_table.revenue
                revenue_table.revenue = revenue
                revenue_table.day_key = day_key
                table.insert(daily, revenue_table)
            end
        end
    end

    return daily
end
-- revenue functions

-- Expense functions: Calculate the net expense of years, months and days and 
-- return a list containing them and a date
function transaction_table.yearly_expenses()
    local yearly = {}

    for year, year_table in pairs(transaction_table.years) do
        local expense_table = {}
        local expense = 0
        local year_key = ""
        year_key = year
        expense = expense + year_table.expenses
        expense_table.expense = expense
        expense_table.year_key = year_key
        table.insert(yearly, expense_table)
    end

    return yearly
end

function transaction_table.monthly_expenses()
    local monthly = {}

    for year, year_table in pairs(transaction_table.years) do
        for month, month_table in pairs(year_table.months) do
            local expense_table = {}
            local expense = 0
            local month_key = ""
            if month < 10 then
                month_key = "0" .. month .. "-" .. year
            else
                month_key = month .. "-" .. year
            end
            expense = expense + month_table.expenses
            expense_table.expense = expense
            expense_table.month_key = month_key
            table.insert(monthly, expense_table)
        end
    end

    return monthly
end

function transaction_table.daily_expenses()
    local daily = {}

    for year, year_table in pairs(transaction_table.years) do
        for month, month_table in pairs(year_table.months) do
            local month_key = ""
            if month < 10 then
                month_key = "0" .. month .. "-" .. year
            else
                month_key = month .. "-" .. year
            end
            for day, day_table in pairs(month_table.days) do
                local expense_table = {}
                local expense = 0
                local day_key = ""
                if day < 10 then
                    day_key = "0" .. day .. "-" .. month_key
                else
                    day_key = day .. "-" .. month_key
                end
                expense = expense + day_table.expenses
                expense_table.expense = expense
                expense_table.day_key = day_key
                table.insert(daily, expense_table)
            end
        end
    end

    return daily
end
-- expense functions

-- Get the sum on the given day. If day nil, give monthly sum, the same for
-- year if month nil.
function transaction_table.get_sum(yearStr, monthStr, dayStr)
    local year = transaction_table.years[yearStr]
    if year == nil then
        return nil
    end
    if monthStr == nil then
        return year.sum
    end
    local month = year.months[monthStr]
    if month == nil then
        return nil
    end
    if dayStr == nil then
        return month.sum
    end
    local day = month.days[dayStr]
    if day == nil then
        return nil
    end
    return day.sum
end

return transaction_table
