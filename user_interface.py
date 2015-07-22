import lupa
from lupa import LuaRuntime

from tkinter import Tk, Label
from DrawFrame import DrawFrame
from TextFrame import TextFrame

def main():

    lua = LuaRuntime(unpack_returned_tuples=True)

    lua_main = lua.eval("require 'lua_main'")

    lua_main.init("test.txt")
    analysis = lua_main.get_analysis()
    transaction_table = lua_main.get_trans_table()

    root = Tk()
    text = TextFrame(root, analysis)
    graphs = DrawFrame(root, transaction_table)
    root.geometry("400x100+300+300")
    root.mainloop()  


main()
