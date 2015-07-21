from tkinter import Canvas, Frame, BOTH

class DrawFrame(Frame):

    def __init__(self, parent):
        Frame.__init__(self, parent)   

        self.parent = parent        
        self.initUI()

    def initUI(self):

        self.parent.title("Graphs")        
        self.pack(fill=BOTH, expand=1)

        canvas = Canvas(self)
        canvas.create_rectangle(30, 10, 120, 80, 
                outline="#fb0", fill="#fb0")
        canvas.create_rectangle(150, 10, 240, 80, 
                outline="#f50", fill="#f50")
        canvas.create_rectangle(270, 10, 370, 80, 
                outline="#05f", fill="#05f")            
        canvas.pack(fill=BOTH, expand=1)
