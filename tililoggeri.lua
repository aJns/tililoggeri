local instructions = require "parse_instructions"
local utils = require "pl.utils"


function main()
    io.write("Enter account transactions file name: ")
    fname = io.read()
    io.write("Enter file format, eg. bank: ")
    fformat = io.read()

    transactions = {}

    parse_file(instructions.nordea, "test.txt", transactions)
end

function parse_file(instructions, filename, transactions)
    local file = assert(io.open(filename, "r"))
    
    local lines = {} 
    for line in file:lines() do
        table.insert(lines, line)
    end

    file:close()

    --remove empty lines, \13 equals \n
    for key,value in pairs(lines) do
        if value == "\13" then
            lines[key] = nil
        else
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


    require 'pl.pretty'.dump(lines)

end

main()
