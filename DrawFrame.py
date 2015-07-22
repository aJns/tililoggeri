from tkinter import Canvas, Frame, BOTH
from datetime import datetime, timedelta

class DrawFrame(Frame):

    def __init__(self, parent, transaction_table):
        Frame.__init__(self, parent)   

        date_table = transaction_table.first_day()
        self.first_date = datetime(date_table.year, date_table.month, date_table.day)

        date_table = transaction_table.last_day()
        self.last_date = datetime(date_table.year, date_table.month, date_table.day)

        self.trans_table = transaction_table
        self.set_graph_limits()

        self.parent = parent        
        self.initUI()

    def initUI(self):

        self.parent.title("Graphs")        
        self.pack(fill=BOTH, expand=1)

        canvas = Canvas(self)

        date = self.first_date
        i = 1
        total_sum = 0
        while(date < self.last_date):
            date += timedelta(days=1)
            year = date.year
            month = date.month
            day = date.day

            if self.trans_table.get_sum(year, month, day) != None:
                total_sum += self.trans_table.get_sum(year, month, day)

            x_coord1 = self.bar_spacing * i
            x_coord2 = x_coord1 + self.bar_width
            y_coord1 = self.vertical_bias
            y_coord2 = total_sum

            if y_coord2 == None: 
                y_coord2 = y_coord1
            else:
                y_coord2 = y_coord2 * self.sum_gain + y_coord1

            # Draw the totalSum on every other day
            if (day % 2) == 0:
                i += 1
                canvas.create_rectangle(x_coord1, y_coord1, x_coord2, y_coord2, 
                        outline="#fb0", fill="#fb0")

        canvas.pack(fill=BOTH, expand=1)

    def set_graph_limits(self):
        self.bar_width = 1
        self.bar_spacing = self.bar_width + 2
        self.vertical_bias = 300
        self.sum_gain = -0.05

        date = self.first_date
        total_sum = 0
        highest_sum = 0
        lowest_sum = 0
        while(date < self.last_date):
            date += timedelta(days=1)
            year = date.year
            month = date.month
            day = date.day

            if self.trans_table.get_sum(year, month, day) != None:
                total_sum += self.trans_table.get_sum(year, month, day)

            if total_sum > highest_sum:
                highest_sum = total_sum
                print(highest_sum)
 
            if total_sum < lowest_sum:
                lowest_sum = total_sum
                print(lowest_sum)

        self.sum_gain = -((self.vertical_bias * 0.9) / highest_sum)
