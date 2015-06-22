local instructions = require "parse_instructions"
local parse = require "parse_functions"
local analysis = require "analysis"


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

    require "pl.pretty".dump(monthly_sums)

end







main()
