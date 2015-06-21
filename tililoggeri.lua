local instructions = require "parse_instructions"


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
        end
    end


    require 'pl.pretty'.dump(lines)

end

main()
