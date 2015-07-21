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

    avgSumStr = ("Average sum:      " + str(analysis.month.avg_sum))
    avgRevStr = ("Average revenue:  " + str(analysis.month.avg_rev))
    avgExpStr = ("Average expense:  " + str(analysis.month.avg_exp))

    medSumStr = ("Median sum:      " + str(analysis.month.med_sum))
    medRevStr = ("Median revenue:  " + str(analysis.month.med_rev))
    medExpStr = ("Median expense:  " + str(analysis.month.med_exp))

    curSumStr = ("Current sum:      " + str(analysis.current_month.sum))
    curRevStr = ("Current revenue:  " + str(analysis.current_month.rev))
    curExpStr = ("Current expense:  " + str(analysis.current_month.exp))

    root = Tk()
    # graphs = DrawFrame(root)
    text = TextFrame(root, analysis)
    root.geometry("400x100+300+300")
    root.mainloop()  


main()
