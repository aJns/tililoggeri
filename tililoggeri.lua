local instructions = require "parse_instructions"
local utils = require "pl.utils"


function main()
    io.write("Enter account transactions file name: ")
    fname = io.read()
    io.write("Enter file format, eg. bank: ")
    fformat = io.read()

    parsed_lines = {}
    parse_file(instructions.nordea, "test.txt", parsed_lines)


    transactions = {}
    format_transactions(instructions.nordea.format, parsed_lines, transactions)

    require 'pl.pretty'.dump(transactions)

end

--parse the file for transactions
function parse_file(instructions, filename, parsed_lines)
    local file = assert(io.open(filename, "r"))
    
    local lines = {} 
    for line in file:lines() do
        table.insert(lines, line)
    end

    file:close()

    for key,value in pairs(lines) do
        --remove empty lines, \13 equals \n
        if value == "\13" then
            lines[key] = nil
        else
            --split the lines at "tabs" (\9 equals \t)
            --and discard unnecessary lines
            splitline = {}
            splitline = utils.split(value, "\9")
            if (splitline[1] == instructions.remove[1] or 
                splitline[1] == instructions.remove[2]) then
                lines[key] = nil
            else
                lines[key] = splitline
            end
        end
    end

    --building the "parsed_lines" table by matching the keyline
    --keys with their corresponding values
    for i,line in pairs(lines) do
        parsed_line = {}
        for j,key in pairs(instructions.keyline) do
            parsed_line[key] = line[j]
        end
        table.insert(parsed_lines,parsed_line)
    end

end

--format the parsed lines in to a more usable transactions table,
--removing unnecessary columns and setting types
function format_transactions(format, parsed_lines, transactions)
    for i,line in pairs(parsed_lines) do
        transaction = {}
        for fkey,column in pairs(format) do
            for key,value in pairs(line) do
                if column == key then
                    transaction[fkey] = value
                end
            end
        end
        table.insert(transactions,transaction)
    end
end






main()
