import file_operations
import user_interface

def main():
    print("Tililoggeri starting...")
    filename = user_interface.get_filename()
    fileformat = user_interface.get_fileformat()
    parsed_lines = []
    file_operations.parse_file(filename, fileformat, parsed_lines)
    print("Tililoggeri exiting...")
    return

main()
