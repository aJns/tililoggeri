from tkinter import Canvas, Frame, BOTH
from datetime import datetime, timedelta

BAR_WIDTH = 1
BAR_SPACING = BAR_WIDTH + 2
VERTICAL_BIAS = 500
SUM_GAIN = -0.05

class DrawFrame(Frame):

    def __init__(self, parent, transaction_table):
        Frame.__init__(self, parent)   

        date_table = transaction_table.first_day()
        self.first_date = datetime(date_table.year, date_table.month, date_table.day)

        date_table = transaction_table.last_day()
        self.last_date = datetime(date_table.year, date_table.month, date_table.day)

        self.trans_table = transaction_table

        self.parent = parent        
        self.initUI()

    def initUI(self):

        self.parent.title("Graphs")        
        self.pack(fill=BOTH, expand=1)

        canvas = Canvas(self)

        date = self.first_date
        i = 1
        totalSum = 0
        while(date < self.last_date):
            date += timedelta(days=1)
            year = date.year
            month = date.month
            day = date.day

            if self.trans_table.get_sum(year, month, day) != None:
                totalSum += self.trans_table.get_sum(year, month, day)

            xCoord1 = BAR_SPACING * i
            xCoord2 = BAR_SPACING * i + BAR_WIDTH
            yCoord1 = VERTICAL_BIAS
            yCoord2 = totalSum

            if yCoord2 == None: 
                yCoord2 = yCoord1
            else:
                yCoord2 = yCoord2 * SUM_GAIN + yCoord1

            # Draw the totalSum on every other day
            if (day % 2) == 0:
                i += 1
                canvas.create_rectangle(xCoord1, yCoord1, xCoord2, yCoord2, 
                        outline="#fb0", fill="#fb0")

        canvas.pack(fill=BOTH, expand=1)
