import lupa
from lupa import LuaRuntime

lua = LuaRuntime(unpack_returned_tuples=True)

lua_main = lua.eval("require 'lua_main'")

lua_main.init("test.txt")
analysis = lua_main.get_analysis()
transaction_table = lua_main.get_trans_table()

# print("Average sum:      ", analysis.month.avg_sum)
# print("Average revenue:  ", analysis.month.avg_rev)
# print("Average expense:  ", analysis.month.avg_exp)

# print("Median sum:      ", analysis.month.med_sum)
# print("Median revenue:  ", analysis.month.med_rev)
# print("Median expense:  ", analysis.month.med_exp)

# print("Current sum:      ", analysis.current_month.sum)
# print("Current revenue:  ", analysis.current_month.rev)
# print("Current expense:  ", analysis.current_month.exp)

print(transaction_table.get_sum(2015, 7, 7))
print(transaction_table.get_sum(2015, 7, 1))
print(transaction_table.get_sum(2015, 7, 2))
print(transaction_table.get_sum(2015, 7, 3))
print(transaction_table.get_sum(2015, 7, 4))
