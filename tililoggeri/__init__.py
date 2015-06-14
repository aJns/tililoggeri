import file_operations
import user_interface
import calc_functions

def main():
    print("Tililoggeri starting...")

    parse_info = {}
    file_operations.read_parse_rules(parse_info)

    filename = user_interface.get_filename()
    fileformat = user_interface.get_fileformat()

    parsed_lines = []
    file_operations.parse_file(parse_info, filename, fileformat, parsed_lines)

    calc_functions.calculate_sum(parsed_lines)
    print("Tililoggeri exiting...")
    return

main()
