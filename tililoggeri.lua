local instructions = require "parse_instructions"
local parse = require "parse_functions"
local trans_table = require "transaction_table"
local analysis = require "analysis"
local gui = require "gui"

function main()
    io.write("Enter account transactions file name: ")
    fname = io.read()
    io.write("Enter file format, eg. bank: ")
    fformat = io.read()

    parsed_lines = {}
    if not parse.parse_file(instructions.nordea, "test.txt", parsed_lines) then
        return
    end

    transactions = parse.format_transactions(instructions.nordea, parsed_lines)

    trans_table.init(transactions)

    total_sum = analysis.netsum(transactions)
    monthly_sums = trans_table.monthly_sums()
    monthly_median = analysis.median_monthly_netsum(trans_table)
    monthly_average = analysis.average_monthly_netsum(trans_table)

    print("Monthly netsums")
    require "pl.pretty".dump(monthly_sums)
    print("Total sum")
    print(total_sum)
    print("Monthly netsum median")
    print(monthly_median)
    print("Monthly netsum average")
    print(monthly_average)

    --gui.set_transactions(transactions)
    --gui.main_window:run()

end

main()
