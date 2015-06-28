local instructions = require "parse_instructions"
local parse = require "parse_functions"
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

    transactions = parse.format_transactions(instructions.nordea.format, parsed_lines)

    monthly_sums = analysis.monthly_netsum(transactions)
    monthly_median = analysis.median_monthly_netsum(transactions)
    monthly_average = analysis.average_monthly_netsum(transactions)

    print("Monthly netsums")
    require "pl.pretty".dump(monthly_sums)
    print("Monthly netsum median")
    print(monthly_median)
    print("Monthly netsum average")
    print(monthly_average)

    --gui.set_transactions(transactions)
    --gui.main_window:run()

end

main()
