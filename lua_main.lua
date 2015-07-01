local lua_main = {}

local instructions = require "parse_instructions"
local parse = require "parse_functions"
local trans_table = require "transaction_table"
local analysis = require "analysis"

function lua_main.init()
    parsed_lines = {}
    if not parse.parse_file(instructions.nordea, "test.txt", parsed_lines) then
        return
    end

    transactions = parse.format_transactions(instructions.nordea, parsed_lines)

    trans_table.init(transactions)

    total_sum = analysis.netsum(transactions)

    yearly_sums = trans_table.yearly_sums()
    monthly_sums = trans_table.monthly_sums()
    daily_sums = trans_table.daily_sums()

    monthly_median = analysis.median_monthly_netsum(trans_table)
    monthly_average = analysis.average_monthly_netsum(trans_table)

end

return lua_main
