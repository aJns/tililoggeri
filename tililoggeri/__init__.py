import file_operations
import user_interface

def main():
    print("Tililoggeri starting...")

    parse_info = {}
    file_operations.read_parse_rules(parse_info)

    filename = user_interface.get_filename()
    fileformat = user_interface.get_fileformat()

    parsed_lines = []
    file_operations.parse_file(parse_info, filename, fileformat, parsed_lines)

    for line in parsed_lines:
        print(line)
    print("Tililoggeri exiting...")
    return

main()
