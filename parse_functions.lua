local parse_functions = {}
local utils = require "pl.utils"
local stringx = require "pl.stringx"

--parse the file for transactions
function parse_functions.parse_file(instructions, filename, parsed_lines)
    local file = io.open(filename, "r")
    if not file then
        print("Couldn't open ", filename)
        return false
    end

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
    return true
end

--format the parsed lines in to a more usable transactions table,
--removing unnecessary columns and setting types
function parse_functions.format_transactions(format, parsed_lines)
    transactions = {}
    for i,line in pairs(parsed_lines) do
        transaction = {}
        for fkey,column in pairs(format) do
            for key,value in pairs(line) do
                if column == key then
                    if fkey == "date" then
                        transaction[fkey] = get_date(value, format.dateformat)
                        elseif fkey == "amount" then
                            transaction[fkey] = stringx.replace(value, ",", ".")
                        else
                            transaction[fkey] = value
                        end
                    end
                end
            end
            table.insert(transactions,transaction)
        end
        return transactions
    end

    function get_date(date_string, dateformat) 
        date = require "pl.Date"{}
        split_date = utils.split(date_string, dateformat.separator, "plain")
        for i,value in pairs(dateformat.order) do
            if value == "d" then
                date:day(tonumber(split_date[i]))
                elseif value == "M" then
                    date:month(tonumber(split_date[i]))
                    elseif value == "y" then
                        date:year(tonumber(split_date[i]))
                    end
                end

                return date
            end

            return parse_functions

