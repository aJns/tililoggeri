# TekUI for lua turned out to be too complicated, so I'm making the gui in
# Python using tkinter

import lupa
from lupa import LuaRuntime

lua = LuaRuntime(unpack_returned_tuples=True)

lua_main = lua.eval("require 'lua_main'")

lua_main.init()
