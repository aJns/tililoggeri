def calculate_sum(transaction_list):
    sum_float = 0.0
    for transaction in transaction_list:
        sum_float += float(transaction["Määrä"].replace(',','.'))
        print("{0:.2f}".format(sum_float) + "\t:\t" + transaction["Saaja/Maksaja"])



