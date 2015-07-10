local analysis = {}
local tablex = require "pl.tablex"

analysis.year = {}
analysis.month = {}
analysis.day = {}

analysis.current_month = {}

function analysis.init(trans_table)
   analysis.year.sums = trans_table.yearly_sums()
   analysis.month.sums = trans_table.monthly_sums()
   analysis.day.sums = trans_table.daily_sums()

   analysis.year.revenues = trans_table.yearly_revenues()
   analysis.month.revenues = trans_table.monthly_revenues()
   analysis.day.revenues = trans_table.daily_revenues()

   analysis.year.expenses = trans_table.yearly_expenses()
   analysis.month.expenses = trans_table.monthly_expenses()
   analysis.day.expenses = trans_table.daily_expenses()

   analysis.month.avg_sum = average_monthly_netsum(trans_table)
   analysis.month.med_sum = median_monthly_netsum(trans_table)

   analysis.month.avg_rev = average_monthly_netrevenue(trans_table)
   analysis.month.med_rev = median_monthly_netrevenue(trans_table)

   analysis.month.avg_exp = average_monthly_netexpense(trans_table)
   analysis.month.med_exp = median_monthly_netexpense(trans_table)

   init_current_month(trans_table)
end

function init_current_month(trans_table)
    local years = tablex.keys(trans_table.years)
    local year = years[1]
    while tablex.size(years) > 1 do
        for i, key in pairs(years) do
            if tonumber(key) > tonumber(year) then
                year = key
            else
                years[i] = nil
            end
        end
    end

    local months = tablex.keys(trans_table.years[year].months)
    local month = months[1]
    while tablex.size(months) > 1 do
        for i, key in pairs(months) do
            if tonumber(key) > tonumber(month) then
                month = key
            else
                months[i] = nil
            end
        end
    end

    analysis.current_month.sum = trans_table.years[year].months[month].sum
    analysis.current_month.exp = trans_table.years[year].months[month].expenses
    analysis.current_month.rev = trans_table.years[year].months[month].revenue
end

-- Sum functions
function median_monthly_netsum(trans_table)
    local monthly = trans_table.monthly_sums()
    monthly = get_monthly_pruned(monthly, (tablex.size(monthly) - 1) / 2, "sum")
    local median = 0
    for i, month in pairs(monthly) do
        median = median + month.sum
    end
    median = median / tablex.size(monthly)
    return median
end

function average_monthly_netsum(trans_table)
    local monthly = trans_table.monthly_sums()
    local average = 0
    for i, month in ipairs(monthly) do
        average = average + month.sum
    end
    average = average / tablex.size(monthly)
    return tonumber(string.format("%.2f", average))
end

-- Revenue functions
function median_monthly_netrevenue(trans_table)
    local monthly = trans_table.monthly_revenues()
    monthly = get_monthly_pruned(monthly, (tablex.size(monthly) - 1) / 2, 
    "revenue")
    local median = 0
    for i, month in pairs(monthly) do
        median = median + month.revenue
    end
    median = median / tablex.size(monthly)
    return median
end

function average_monthly_netrevenue(trans_table)
    local monthly = trans_table.monthly_revenues()
    local average = 0
    for i, month in ipairs(monthly) do
        average = average + month.revenue
    end
    average = average / tablex.size(monthly)
    return tonumber(string.format("%.2f", average))
end

-- Expense functions
function median_monthly_netexpense(trans_table)
    local monthly = trans_table.monthly_expenses()
    monthly = get_monthly_pruned(monthly, (tablex.size(monthly) - 1) / 2, 
    "expense")
    local median = 0
    for i, month in pairs(monthly) do
        median = median + month.expense
    end
    median = median / tablex.size(monthly)
    return median
end

function average_monthly_netexpense(trans_table)
    local monthly = trans_table.monthly_expenses()
    local average = 0
    for i, month in ipairs(monthly) do
        average = average + month.expense
    end
    average = average / tablex.size(monthly)
    return tonumber(string.format("%.2f", average))
end

-- A function for removing extremes from monthly transactions
-- The amount specified by remove_count is removed at each end of the list
-- Key is the type of calculation: sum, revenue, or expense
function get_monthly_pruned(monthly_arg, remove_count, key)
    local key = key
    local monthly = tablex.deepcopy(monthly_arg)
    local remove = remove_count
    for i=1, remove, 1 do
        --Gets a random key from monthly
        start_key = tablex.keys(monthly)[1]
        local highest = monthly[start_key][key]
        local lowest = monthly[start_key][key]
        local hKey = start_key
        local lKey = start_key
        for i, month_table in pairs(monthly) do
            local calc = month_table[key]
            local month = i
            if calc > highest then
                highest = calc
                hKey = month
            end
            if calc < lowest then
                lowest = calc
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
    return monthly
end

return analysis
