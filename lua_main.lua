local lua_main = {}

local instructions = require "parse_instructions"
local parse = require "parse_functions"
local trans_table = require "transaction_table"
local analysis = require "analysis"

function lua_main.init(filename)
    parsed_lines = {}
    if not parse.parse_file(instructions.nordea, filename, parsed_lines) then
        return
    end

    transactions = parse.format_transactions(instructions.nordea, parsed_lines)

    trans_table.init(transactions)

    analysis.init(trans_table)

end

function lua_main.get_trans_table() 
    return trans_table
end

function lua_main.get_analysis()
    return analysis
end

return lua_main
