local transaction_table = {}
local tablex = require "pl.tablex"

function transaction_table.init(trans_arg)
    transaction_table.transactions = tablex.deepcopy(trans_arg)

    transaction_table.years = {}
    transaction_table.years.months = {}
    transaction_table.years.months.days = {}

    local transactions = transaction_table.transactions
    local count = 0
    for i, line in ipairs(transactions) do
        print("year loop", year, count)
        require "pl.pretty".dump(line)
        local year = line.date:year()
        local year_list = transaction_table.years[year]
        if year_list == nil then
            transaction_table.years[year] = {}
            transaction_table.years[year].transactions = {}
            year_list = transaction_table.years[year]
            year_list.months = {}
        end
        table.insert(year_list.transactions, line)
        count = count + 1
    end

    local count = 0
    for year, transactions in pairs(transaction_table.years) do
        for i, line in pairs(transactions) do
            print("month loop", year, month, count)
            require "pl.pretty".dump(line)
            local month = line.date:month()
            local month_list = transaction_table.years[year].months[month]
            if month_list == nil then
                transaction_table.years[year].months[month] = {}
                transaction_table.years[year].months[month].transactions = {}
                month_list = transaction_table.years[year].months[month]
                month_list.days = {}
            end
            table.insert(month_list.transactions, line)
            count = count + 1
        end
    end

    local count = 0
    for month, transactions in pairs(transaction_table.years.months) do
        for i, line in pairs(transactions) do
            print("day loop", year, month, day, count)
            require "pl.pretty".dump(line)
            local day = line.date:day()
            local day_list = transaction_table.years[year].months[month].days[day]
            if day_list == nil then
                transaction_table.years[year].months[month].days[day]  = {}
                transaction_table.years[year].months[month].days[day].transactions = {}
                day_list = transaction_table.years[year].months[month].days[day]
            end
            table.insert(day_list.transactions, line)
            count = count + 1
        end
    end

    for key,year in pairs(transaction_table.years) do
        print("year", year)
        for key,month in pairs(transaction_table.years.months) do
            print("month", month)
            for key,day in pairs(transaction_table.years.months.days) do
                print("day", day)
            end
        end
    end

end

return transaction_table
