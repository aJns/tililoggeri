from tkinter import Label, Frame, BOTH, W, LEFT

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
        self.pack(fill=BOTH, side=LEFT)

        analysis = self.analysis

        avgSumStr = ("Average sum:      " + str(analysis.month.avg_sum))
        avgRevStr = ("Average revenue:  " + str(analysis.month.avg_rev))
        avgExpStr = ("Average expense:  " + str(analysis.month.avg_exp))

        medSumStr = ("Median sum:      " + str(analysis.month.med_sum))
        medRevStr = ("Median revenue:  " + str(analysis.month.med_rev))
        medExpStr = ("Median expense:  " + str(analysis.month.med_exp))

        curSumStr = ("Current sum:      " + str(analysis.current_month.sum))
        curRevStr = ("Current revenue:  " + str(analysis.current_month.rev))
        curExpStr = ("Current expense:  " + str(analysis.current_month.exp))

        superString = (avgSumStr
                +  "\n" + avgRevStr
                +  "\n" + avgExpStr

                +  "\n" + medSumStr
                +  "\n" + medRevStr
                +  "\n" + medExpStr

                +  "\n" + curSumStr
                +  "\n" + curRevStr
                +  "\n" + curExpStr
                )

        superLabel = Label(self, text=superString, anchor=W, justify=LEFT)
        superLabel.pack()
