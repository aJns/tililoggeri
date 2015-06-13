def get_filename():
    filename = input("Account transactions file filename: ")
    if filename == "":
        filename = "test.txt"
    return filename

def get_fileformat():
    fileformat = input("File format (eg bank name, default=Nordea): ")
    if fileformat == "":
        fileformat = "Nordea"
    return fileformat.lower()
