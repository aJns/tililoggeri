def parse_file(filename, fileformat, parsed_lines):
    try:
        transactionfile = open(filename)
    except:
        print(filename + " could not be opened")
        return False

    if fileformat == "nordea":
        lines = transactionfile.read().splitlines()
        lines = [line for line in lines if line.strip()]

        key_line = lines[1].strip().split("\t")

        i = 2
        while i < len(lines):
            dictionary = {}
            line = lines[i].split("\t")
            j = 0
            for key in key_line: 
                    dictionary[key] = line[j]
                    j += 1
            i += 1

            parsed_lines.append(dictionary)

    transactionfile.close()
    return True

