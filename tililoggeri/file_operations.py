def parse_file(filename, fileformat, parsed_lines):
    try:
        transactionfile = open(filename)
    except:
        print(filename + " could not be opened")
        return False

    if fileformat == "nordea":
        lines = transactionfile.read().splitlines()
        lines = [line for line in lines if line.strip()]
        for line in lines:
            line = line.split("\t")

    for line in lines:
        print(line)

    transactionfile.close()
    return True

