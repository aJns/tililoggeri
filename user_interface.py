import lupa
from lupa import LuaRuntime

lua = LuaRuntime(unpack_returned_tuples=True)

lua_main = lua.eval("require 'lua_main'")

lua_main.init()
analysis = lua_main.get_analysis()
transaction_table = lua_main.get_trans_table()

print(analysis.month.avg_sum)
print(analysis.month.avg_rev)
print(analysis.month.avg_exp)
