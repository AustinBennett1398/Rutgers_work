from tkinter import *
from PIL import ImageTk, Image
import os
import sys
import random
import time
import blackjack
import war
import oldmaid

window = Tk()
window.title("CS 314 final project")
window.geometry('480x360')

def blackjackClicked():
    window.destroy()
    a = blackjack.Application()

def warClicked():
    window.destroy()
    a = war.Application()
    #insert your code here
    #exec(open("war.py").read())


def oldmaidClicked():
    window.destroy()
    a=oldmaid.Application()

blackjackBtn = Button(window, text="Blackjack", command=blackjackClicked, height=2, width=10)
blackjackBtn.pack(side='left', padx=30, anchor='w')

warBtn = Button(window, text="War", command=warClicked, height=2, width=10)
warBtn.pack(side='left', padx=30, anchor='w')

oldmaidBtn = Button(window, text="Old Maid", command=oldmaidClicked, height=2, width=10)
oldmaidBtn.pack(side='left', padx=30, anchor='w')

window.mainloop()

#to test
#pyinstaller --onefile --exclude-module PyQt5 startup.py

#final
#pyinstaller --onefile --windowed --exclude-module PyQt5 startup.py


#pyinstaller --onefile --exclude-module PyQt5 startup.spec

#pyinstaller --onefile --workpath .\compile\build --distpath .\compile\dist --specpath .\compile startup.py 