from tkinter import Canvas, Frame, BOTH
from datetime import datetime, timedelta

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

            xCoord1 = 30 * i
            xCoord2 = 30 * i + 20
            yCoord1 = 10
            yCoord2 = self.trans_table.get_sum(year, month, day)

            if yCoord2 == None: 
                yCoord2 = yCoord1

            canvas.create_rectangle(xCoord1, yCoord1, xCoord2, yCoord2, 
                    outline="#fb0", fill="#fb0")

        canvas.pack(fill=BOTH, expand=1)
