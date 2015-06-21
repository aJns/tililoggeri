local instructions = require "parse_instructions"


function main()
    io.write("Enter account transactions file name: ")
    fname = io.read()
    io.write("Enter file format, eg. bank: ")
    fformat = io.read()

    parse_file(i, "test.txt", ff, tr)
end

function parse_file(instructions, filename, fileformat, transactions)
    local file = assert(io.open(filename, "r"))
    
    local lines = {} 
    for line in file:lines() do
        table.insert(lines, line)
    end

    file:close()

    require 'pl.pretty'.dump(lines)

    return
end

main()
