from tkinter import Label, Frame, BOTH

import lupa
from lupa import LuaRuntime

class TextFrame(Frame):

    def __init__(self, parent, analysis):
        Frame.__init__(self, parent)   

        # analysis is a lua table
        self.analysis = analysis

        self.parent = parent        
        self.initUI()

    def initUI(self):

        self.parent.title("Text")        
        self.pack(fill=BOTH, expand=1)

        avgSumStr = ("Average sum:      " + str(self.analysis.month.avg_sum))
        avgSumLab = Label(self, text=avgSumStr)
        avgSumLab.pack()
