def parse_file(parse_rules, filename, fileformat, parsed_lines):
    try:
        transactionfile = open(filename)
    except:
        print(filename + " could not be opened")
        return False

    if fileformat in parse_rules:
        ruleset = parse_rules[fileformat]
        lines = transactionfile.read().splitlines()
        lines = [line for line in lines if line.strip()]

        keyline = ruleset["keyline"]
        separator = ruleset["separator"]

        i = ruleset["startline"]
        while i < len(lines):
            dictionary = {}
            line = lines[i].split(separator)
            j = 0
            for key in keyline: 
                    dictionary[key] = line[j]
                    j += 1
            i += 1

            parsed_lines.append(dictionary)

    transactionfile.close()
    return True

def read_parse_rules(parse_info):
    try:
        rules_file = open("parse_rules")
    except:
        print("Could not read parse rules")
        return False

    lines = rules_file.read().splitlines()
    lines = [line for line in lines if line.strip()]

    i = 0
    while i < len(lines):
        line = lines[i].strip().split("=")
        if line[0] == "parse_rules":
            ruleset = line[1]
            rules = {}
            parse_info[ruleset] = rules
            i += 1
            while lines[i].strip().split("=")[0] != "parse_rules_stop":
                line = lines[i].strip().split("=")
                if line[0] == "field_separator":
                    if line[1] == "'tab'":
                        rules["separator"] = "\t"
                    else:
                        rules["separator"] = line[1]
                if line[0] == "transaction_startline":
                    rules["startline"] = int(line[1])
                if line[0] == "keyline_start":
                    i += 1
                    keylist = []
                    while lines[i].strip().split("=")[0] != "keyline_stop":
                        line = lines[i].strip().split("=")
                        keylist.append(line[0])
                        i += 1
                    rules["keyline"] = keylist
                i += 1
        i += 1

    rules_file.close()
    return True

