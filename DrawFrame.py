from tkinter import Canvas, Frame, BOTH
from datetime import datetime, timedelta

BAR_WIDTH = 10
BAR_SPACING = 5
VERTICAL_BIAS = 200
SUM_GAIN = -0.25

class DrawFrame(Frame):

    def __init__(self, parent, transaction_table):
        Frame.__init__(self, parent)   

        self.trans_table = transaction_table

        self.parent = parent        
        self.initUI()

    def initUI(self):

        self.parent.title("Graphs")        
        self.pack(fill=BOTH, expand=1)

        canvas = Canvas(self)

        date = datetime(2015, 1, 1)
        for i in range(60):
            date += timedelta(days=1)
            year = date.year
            month = date.month
            day = date.day

            xCoord1 = BAR_SPACING * i
            xCoord2 = BAR_SPACING * i + BAR_WIDTH
            yCoord1 = VERTICAL_BIAS
            yCoord2 = self.trans_table.get_sum(year, month, day)

            if yCoord2 == None: 
                yCoord2 = yCoord1
            else:
                yCoord2 = yCoord2 * SUM_GAIN + yCoord1
                print(yCoord2)

            canvas.create_rectangle(xCoord1, yCoord1, xCoord2, yCoord2, 
                    outline="#fb0", fill="#fb0")

        canvas.pack(fill=BOTH, expand=1)
