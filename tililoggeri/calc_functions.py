def calculate_sum(transaction_list):
    sum_float = 0.0
    for transaction in transaction_list:
        sum_float += float(transaction["Määrä"].replace(',','.'))
        print(sum_float)



