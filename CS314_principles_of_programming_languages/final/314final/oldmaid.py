from tkinter import *
from PIL import ImageTk, Image
import os
import sys
import random
import time

class Card:
    def __init__(self, value, suit):
        self.value=value
        self.suit=suit
    def __eq__(self, obj): #Cards are equal if they have the same value (suit is disregarded)
        if(isinstance(obj, Card)):
            if(self.value==obj.value):
                return True
            else:
                return False
        else:
            return False

class Application:
    def __init__(self):
        if(sys.platform.startswith("win32")):
            self.platform = "windows"
        elif(sys.platform.startswith("linux")):
            self.platform = "linux"
        self.values=["ace",2,3,4,5,6,7,8,9,10,"jack","queen","king"]
        self.suits=["diamonds", "spades", "clubs", "hearts"]

        #deck is a list of Card objects
        self.deck=[Card(x,y) for x in self.values for y in self.suits]
    
        #Remove three Queens from the deck
        self.deck.remove(Card("queen", "spades"))
        self.deck.remove(Card("queen", "diamonds"))
        self.deck.remove(Card("queen", "clubs"))
        
        random.shuffle(self.deck)
        self.playerDeck=[]

        #Split the deck between the computer and player (user)
        for _ in range(int(len(self.deck)/2)):
            self.playerDeck.append((self.deck).pop(0))
        
        #Who goes first is decided randomly 
        self.turn=random.randint(0, 1)
        self.window=Tk()
        self.window.title("Old Maid")
        self.window.configure(background="green")
        self.window.state("normal") #the window size adjusts depending on the number of cards in play

        #Tkinter window consists of three frames
        self.computerFrame=Frame(self.window, background="green")
        self.computerFrame.grid(padx=25, pady=30)

        self.centerFrame=Frame(self.window, background="green")
        self.centerFrame.grid(padx=25, pady=50)

        self.playerFrame=Frame(self.window, bg="green")
        self.playerFrame.grid(padx=25)

        #References to all card images
        if(self.platform == "windows"):
            self.path0 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "back1.gif"
            self.back = ImageTk.PhotoImage(Image.open(self.path0))
            self.path1 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "2clubs.gif"
            self.clubs2= ImageTk.PhotoImage(Image.open(self.path1))
            self.path2 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "2diamonds.gif"
            self.diamonds2= ImageTk.PhotoImage(Image.open(self.path2))
            self.path3 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "2hearts.gif"
            self.hearts2= ImageTk.PhotoImage(Image.open(self.path3))
            self.path4 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "2spades.gif"
            self.spades2= ImageTk.PhotoImage(Image.open(self.path4))

            self.path5 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "3clubs.gif"
            self.clubs3= ImageTk.PhotoImage(Image.open(self.path5))
            self.path6 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "3diamonds.gif"
            self.diamonds3= ImageTk.PhotoImage(Image.open(self.path6))
            self.path7 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "3hearts.gif"
            self.hearts3= ImageTk.PhotoImage(Image.open(self.path7))
            self.path8 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "3spades.gif"
            self.spades3= ImageTk.PhotoImage(Image.open(self.path8))

            self.path9 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "4clubs.gif"
            self.clubs4= ImageTk.PhotoImage(Image.open(self.path9))
            self.path10 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "4diamonds.gif"
            self.diamonds4= ImageTk.PhotoImage(Image.open(self.path10))
            self.path11 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "4hearts.gif"
            self.hearts4= ImageTk.PhotoImage(Image.open(self.path11))
            self.path12 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "4spades.gif"
            self.spades4= ImageTk.PhotoImage(Image.open(self.path12))

            self.path13 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "5clubs.gif"
            self.clubs5= ImageTk.PhotoImage(Image.open(self.path13))
            self.path14 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "5diamonds.gif"
            self.diamonds5= ImageTk.PhotoImage(Image.open(self.path14))
            self.path15 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "5hearts.gif"
            self.hearts5= ImageTk.PhotoImage(Image.open(self.path15))
            self.path16 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "5spades.gif"
            self.spades5= ImageTk.PhotoImage(Image.open(self.path16))

            self.path17 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "6clubs.gif"
            self.clubs6= ImageTk.PhotoImage(Image.open(self.path17))
            self.path18 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "6diamonds.gif"
            self.diamonds6= ImageTk.PhotoImage(Image.open(self.path18))
            self.path19 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "6hearts.gif"
            self.hearts6= ImageTk.PhotoImage(Image.open(self.path19))
            self.path20 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "6spades.gif"
            self.spades6= ImageTk.PhotoImage(Image.open(self.path20))

            self.path21 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "7clubs.gif"
            self.clubs7= ImageTk.PhotoImage(Image.open(self.path21))
            self.path22 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "7diamonds.gif"
            self.diamonds7= ImageTk.PhotoImage(Image.open(self.path22))
            self.path23 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "7hearts.gif"
            self.hearts7= ImageTk.PhotoImage(Image.open(self.path23))
            self.path24 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "7spades.gif"
            self.spades7= ImageTk.PhotoImage(Image.open(self.path24))

            self.path25 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "8clubs.gif"
            self.clubs8= ImageTk.PhotoImage(Image.open(self.path25))
            self.path26 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "8diamonds.gif"
            self.diamonds8= ImageTk.PhotoImage(Image.open(self.path26))
            self.path27 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "8hearts.gif"
            self.hearts8= ImageTk.PhotoImage(Image.open(self.path27))
            self.path28 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "8spades.gif"
            self.spades8= ImageTk.PhotoImage(Image.open(self.path28))

            self.path29 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "9clubs.gif"
            self.clubs9= ImageTk.PhotoImage(Image.open(self.path29))
            self.path30 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "9diamonds.gif"
            self.diamonds9= ImageTk.PhotoImage(Image.open(self.path30))
            self.path31 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "9hearts.gif"
            self.hearts9= ImageTk.PhotoImage(Image.open(self.path31))
            self.path32 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "9spades.gif"
            self.spades9= ImageTk.PhotoImage(Image.open(self.path32))

            self.path33 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "10clubs.gif"
            self.clubs10= ImageTk.PhotoImage(Image.open(self.path33))
            self.path34 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "10diamonds.gif"
            self.diamonds10= ImageTk.PhotoImage(Image.open(self.path34))
            self.path35 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "10hearts.gif"
            self.hearts10= ImageTk.PhotoImage(Image.open(self.path35))
            self.path36 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "10spades.gif"
            self.spades10= ImageTk.PhotoImage(Image.open(self.path36))

            self.path37 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "aceclubs.gif"
            self.clubsace= ImageTk.PhotoImage(Image.open(self.path37))
            self.path38 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "acediamonds.gif"
            self.diamondsace= ImageTk.PhotoImage(Image.open(self.path38))
            self.path39 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "acehearts.gif"
            self.heartsace= ImageTk.PhotoImage(Image.open(self.path39))
            self.path40 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "acespades.gif"
            self.spadesace= ImageTk.PhotoImage(Image.open(self.path40))

            self.path41 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "jackclubs.gif"
            self.clubsjack= ImageTk.PhotoImage(Image.open(self.path41))
            self.path42 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "jackdiamonds.gif"
            self.diamondsjack= ImageTk.PhotoImage(Image.open(self.path42))
            self.path43 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "jackhearts.gif"
            self.heartsjack= ImageTk.PhotoImage(Image.open(self.path43))
            self.path44 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "jackspades.gif"
            self.spadesjack= ImageTk.PhotoImage(Image.open(self.path44))

            self.path45 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "queenclubs.gif"
            self.clubsqueen= ImageTk.PhotoImage(Image.open(self.path45))
            self.path46 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "queendiamonds.gif"
            self.diamondsqueen= ImageTk.PhotoImage(Image.open(self.path46))
            self.path47 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "queenhearts.gif"
            self.heartsqueen= ImageTk.PhotoImage(Image.open(self.path47))
            self.path48 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "queenspades.gif"
            self.spadesqueen= ImageTk.PhotoImage(Image.open(self.path48))

            self.path49 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "kingclubs.gif"
            self.clubsking= ImageTk.PhotoImage(Image.open(self.path49))
            self.path50 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "kingdiamonds.gif"
            self.diamondsking= ImageTk.PhotoImage(Image.open(self.path50))
            self.path51 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "kinghearts.gif"
            self.heartsking= ImageTk.PhotoImage(Image.open(self.path51))
            self.path52 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "kingspades.gif"
            self.spadesking= ImageTk.PhotoImage(Image.open(self.path52))  
        elif(self.platform == "linux"):
            self.path0 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "back1.GIF"
            self.back = ImageTk.PhotoImage(Image.open(self.path0))
            self.path1 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "2clubs.GIF"
            self.clubs2= ImageTk.PhotoImage(Image.open(self.path1))
            self.path2 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "2diamonds.GIF"
            self.diamonds2= ImageTk.PhotoImage(Image.open(self.path2))
            self.path3 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "2hearts.GIF"
            self.hearts2= ImageTk.PhotoImage(Image.open(self.path3))
            self.path4 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "2spades.GIF"
            self.spades2= ImageTk.PhotoImage(Image.open(self.path4))

            self.path5 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "3clubs.GIF"
            self.clubs3= ImageTk.PhotoImage(Image.open(self.path5))
            self.path6 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "3diamonds.GIF"
            self.diamonds3= ImageTk.PhotoImage(Image.open(self.path6))
            self.path7 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "3hearts.GIF"
            self.hearts3= ImageTk.PhotoImage(Image.open(self.path7))
            self.path8 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "3spades.GIF"
            self.spades3= ImageTk.PhotoImage(Image.open(self.path8))

            self.path9 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "4clubs.GIF"
            self.clubs4= ImageTk.PhotoImage(Image.open(self.path9))
            self.path10 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "4diamonds.GIF"
            self.diamonds4= ImageTk.PhotoImage(Image.open(self.path10))
            self.path11 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "4hearts.GIF"
            self.hearts4= ImageTk.PhotoImage(Image.open(self.path11))
            self.path12 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "4spades.GIF"
            self.spades4= ImageTk.PhotoImage(Image.open(self.path12))

            self.path13 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "5clubs.GIF"
            self.clubs5= ImageTk.PhotoImage(Image.open(self.path13))
            self.path14 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "5diamonds.GIF"
            self.diamonds5= ImageTk.PhotoImage(Image.open(self.path14))
            self.path15 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "5hearts.GIF"
            self.hearts5= ImageTk.PhotoImage(Image.open(self.path15))
            self.path16 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "5spades.GIF"
            self.spades5= ImageTk.PhotoImage(Image.open(self.path16))

            self.path17 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "6clubs.GIF"
            self.clubs6= ImageTk.PhotoImage(Image.open(self.path17))
            self.path18 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "6diamonds.GIF"
            self.diamonds6= ImageTk.PhotoImage(Image.open(self.path18))
            self.path19 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "6hearts.GIF"
            self.hearts6= ImageTk.PhotoImage(Image.open(self.path19))
            self.path20 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "6spades.GIF"
            self.spades6= ImageTk.PhotoImage(Image.open(self.path20))

            self.path21 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "7clubs.GIF"
            self.clubs7= ImageTk.PhotoImage(Image.open(self.path21))
            self.path22 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "7diamonds.GIF"
            self.diamonds7= ImageTk.PhotoImage(Image.open(self.path22))
            self.path23 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "7hearts.GIF"
            self.hearts7= ImageTk.PhotoImage(Image.open(self.path23))
            self.path24 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "7spades.GIF"
            self.spades7= ImageTk.PhotoImage(Image.open(self.path24))

            self.path25 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "8clubs.GIF"
            self.clubs8= ImageTk.PhotoImage(Image.open(self.path25))
            self.path26 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "8diamonds.GIF"
            self.diamonds8= ImageTk.PhotoImage(Image.open(self.path26))
            self.path27 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "8hearts.GIF"
            self.hearts8= ImageTk.PhotoImage(Image.open(self.path27))
            self.path28 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "8spades.GIF"
            self.spades8= ImageTk.PhotoImage(Image.open(self.path28))

            self.path29 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "9clubs.GIF"
            self.clubs9= ImageTk.PhotoImage(Image.open(self.path29))
            self.path30 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "9diamonds.GIF"
            self.diamonds9= ImageTk.PhotoImage(Image.open(self.path30))
            self.path31 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "9hearts.GIF"
            self.hearts9= ImageTk.PhotoImage(Image.open(self.path31))
            self.path32 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "9spades.GIF"
            self.spades9= ImageTk.PhotoImage(Image.open(self.path32))

            self.path33 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "10clubs.GIF"
            self.clubs10= ImageTk.PhotoImage(Image.open(self.path33))
            self.path34 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "10diamonds.GIF"
            self.diamonds10= ImageTk.PhotoImage(Image.open(self.path34))
            self.path35 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "10hearts.GIF"
            self.hearts10= ImageTk.PhotoImage(Image.open(self.path35))
            self.path36 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "10spades.GIF"
            self.spades10= ImageTk.PhotoImage(Image.open(self.path36))

            self.path37 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "aceclubs.GIF"
            self.clubsace= ImageTk.PhotoImage(Image.open(self.path37))
            self.path38 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "acediamonds.GIF"
            self.diamondsace= ImageTk.PhotoImage(Image.open(self.path38))
            self.path39 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "acehearts.GIF"
            self.heartsace= ImageTk.PhotoImage(Image.open(self.path39))
            self.path40 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "acespades.GIF"
            self.spadesace= ImageTk.PhotoImage(Image.open(self.path40))

            self.path41 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "jackclubs.GIF"
            self.clubsjack= ImageTk.PhotoImage(Image.open(self.path41))
            self.path42 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "jackdiamonds.GIF"
            self.diamondsjack= ImageTk.PhotoImage(Image.open(self.path42))
            self.path43 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "jackhearts.GIF"
            self.heartsjack= ImageTk.PhotoImage(Image.open(self.path43))
            self.path44 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "jackspades.GIF"
            self.spadesjack= ImageTk.PhotoImage(Image.open(self.path44))

            self.path45 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "queenclubs.GIF"
            self.clubsqueen= ImageTk.PhotoImage(Image.open(self.path45))
            self.path46 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "queendiamonds.GIF"
            self.diamondsqueen= ImageTk.PhotoImage(Image.open(self.path46))
            self.path47 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "queenhearts.GIF"
            self.heartsqueen= ImageTk.PhotoImage(Image.open(self.path47))
            self.path48 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "queenspades.GIF"
            self.spadesqueen= ImageTk.PhotoImage(Image.open(self.path48))

            self.path49 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "kingclubs.GIF"
            self.clubsking= ImageTk.PhotoImage(Image.open(self.path49))
            self.path50 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "kingdiamonds.GIF"
            self.diamondsking= ImageTk.PhotoImage(Image.open(self.path50))
            self.path51 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "kinghearts.GIF"
            self.heartsking= ImageTk.PhotoImage(Image.open(self.path51))
            self.path52 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "kingspades.GIF"
            self.spadesking= ImageTk.PhotoImage(Image.open(self.path52))
            
        #Print the initial hands
        self.ccol=0
        self.ccol2=0
        for _ in self.deck:
            ccImage = Label(self.computerFrame, image = self.back)
            if self.ccol<17:
                ccImage.grid(row=0, column=self.ccol)
                self.ccol=self.ccol+1
            else:
                ccImage.grid(row=1, column=self.ccol2)
                self.ccol2=self.ccol2+1

        self.ccol=0
        self.ccol2=0
        for p in self.playerDeck:
            ccImage = Label(self.playerFrame, image=eval("self."+(p.suit+str(p.value))))
            if self.ccol<17:
                ccImage.grid(row=0, column=self.ccol)
                self.ccol=self.ccol+1
            else:
                ccImage.grid(row=1, column=self.ccol2)
                self.ccol2=self.ccol2+1 

        #Display rules and button that starts game
        self.startLabel1=Label(self.centerFrame, text="Three queens have been removed from the deck. The deck has been shuffled and is split between you and the computer.", font=("Cambria", 14), fg="white", bg="green")
        self.startLabel2=Label(self.centerFrame, text="Pairs of cards with the same value are removed throughout gameplay. Click remove pairs to begin the game. Remember, do not get stuck with the queen!", font=("Cambria", 14), fg="white", bg="green")
        self.startLabel1.grid()
        self.startLabel2.grid()
        self.firstRemovePairsButton= Button(self.centerFrame, text="Remove Pairs", command=self.startGame, font=("Cambria", 14), fg="white", bg="green")
        self.firstRemovePairsButton.grid(pady=10)
        self.window.mainloop()

    #Removes pairs of two or four cards with the same value (suit does not matter)
    def pairRemover(self,d):
        for _ in range(2):
            removalList=[]
            for c in d:
                if (d.count(c) > 1):
                    if c not in removalList:
                        removalList.append(c)
            
            for dup in removalList:
                for _ in range(2):
                    d.remove(dup)

    #Deletes all widgets from the three frames and adjusts spacing within the window
    def frameReset(self):
        for widget in self.computerFrame.winfo_children():
            widget.destroy()
        for widget in self.centerFrame.winfo_children():
            widget.destroy()
        for widget in self.playerFrame.winfo_children():
            widget.destroy()
        self.computerFrame.grid(padx=350, pady=30)
        self.centerFrame.grid(padx=350, pady=80)
        self.playerFrame.grid(padx=350)
        
    #Prints the current hands of the computer and player
    def printDecks(self):
        col=0
        col2=0
        x=1
        if len(self.deck)==0:
            emptyLabel=Label(self.computerFrame, text="[Computer's hand is empty]", font=("Cambria", 18), fg="white", bg="green")
            emptyLabel.grid(pady=45)
        if len(self.playerDeck)==0:
            emptyLabel=Label(self.playerFrame, text="[Your hand is empty]", font=("Cambria", 18), fg="white", bg="green")
            emptyLabel.grid()
        for _ in self.deck:
            ccImage= Label(self.computerFrame, image = self.back)
            cLabel= Label(self.computerFrame, text = str(x), font=("Cambria", 18), fg="white", bg="green")
            if col<17:
                ccImage.grid(row=0, column=col)
                cLabel.grid(row=1, column=col)
                col=col+1
                x=x+1
            else:
                ccImage.grid(row=2, column=col2)
                cLabel.grid(row=3, column=col)
                col2=col2+1
                x=x+1
        col=0
        col2=0
        for p in self.playerDeck:
            ccImage = Label(self.playerFrame, image=eval("self."+p.suit+str(p.value)))
            if col<17:
                ccImage.grid(row=0, column=col)
                col=col+1
            else:
                ccImage.grid(row=1, column=col2)
                col2=col2+1 

    #Deletes frames, prints winner and lets player exit
    def endGame(self):
        self.computerFrame.destroy()
        self.centerFrame.destroy()
        self.playerFrame.destroy()
        if len(self.deck)==0:
            winLabel=Label(self.window, text="Computer wins! :-(", font=("Cambria", 40), fg="white", bg="green")
            winLabel.grid(padx=500, pady=280)
        else:
            winLabel=Label(self.window, text="You win!", font=("Cambria", 40), fg="white", bg="green")
            winLabel.grid(padx=575, pady=280)
        exitButton= Button(self.window, text="Exit", command=sys.exit, font=("Cambria", 18), fg="white", bg="green")
        exitButton.grid()

    #Handles all gameplay and calls other methods to update the game's state for the GUI
    def playGame(self):
        while len(self.deck) > 0 and len(self.playerDeck) > 0:
            self.frameReset()
            self.printDecks()
            if self.turn==0:
                pickLabel=Label(self.centerFrame, text="It is your turn. Pick a card from the computer's deck:", font=("Cambria", 14), fg="white", bg="green")
                pickLabel.grid()
                buttonFrame=Frame(self.centerFrame, background="green")
                buttonFrame.grid(pady=80)
                choice=IntVar()
                for x in range(len(self.deck)):
                    rb= Radiobutton(buttonFrame, text=str(x+1), variable=choice, value=x, font=("Cambria", 14), fg="white", bg="green")
                    rb.grid(row=1, column=x)
                    if x == len(self.deck)-1:
                        rb.wait_variable(choice) #waits for player's pick before proceeding
                self.frameReset()
                self.printDecks()
                pickLabel2=Label(self.centerFrame, text="You picked:", font=("Cambria", 14), fg="white", bg="green")
                pickLabel2.grid()
                curCard=self.deck[choice.get()]
                cImage = Label(self.centerFrame, image=eval("self."+curCard.suit+str(curCard.value))) #Displays which card the player picked
                cImage.grid(pady=10)
                var1=IntVar()
                ackButton= Button(self.centerFrame, text="Acknowledge", command=lambda: var1.set(1), font=("Cambria", 14), fg="white", bg="green")
                ackButton.grid(pady=20)
                ackButton.wait_variable(var1) #waits for player input before proceeding
                self.playerDeck.append(self.deck.pop(choice.get()))
                self.frameReset()
                self.printDecks()
                var2=IntVar()
                removePairsButton= Button(self.centerFrame, text="Remove your Pairs", command=lambda: var2.set(1), font=("Cambria", 14), fg="white", bg="green")
                removePairsButton.grid(pady=95)
                removePairsButton.wait_variable(var2) #waits for player to view their deck before removing pairs
                self.pairRemover(self.playerDeck)
                self.turn=1 #with pairs removed, turns switch
            else:
                pickLabel=Label(self.centerFrame, text="It is the computer's turn. The computer has picked your:", font=("Cambria", 14), fg="white", bg="green")
                pickLabel.grid()
                randomIndex=random.randint(0, len(self.playerDeck)-1) #Computer picks randomly from player's deck (no need to reshuffle player's deck before pick)
                curCard=self.playerDeck[randomIndex]
                cImage = Label(self.centerFrame, image=eval("self."+curCard.suit+str(curCard.value))) #display computer's pick
                cImage.grid(pady=10)
                var1=IntVar()
                ackButton= Button(self.centerFrame, text="Acknowledge", command=lambda: var1.set(1), font=("Cambria", 14), fg="white", bg="green")
                ackButton.grid(pady=20)
                ackButton.wait_variable(var1) #player sees which card was taken by the computer
                self.deck.append(self.playerDeck.pop(randomIndex))
                self.frameReset()
                self.printDecks()
                var2=IntVar()
                dupLabel=Label(self.centerFrame, text="The computer is removing its pairs.", font=("Cambria", 14), fg="white", bg="green")
                dupLabel.grid()
                removePairsButton= Button(self.centerFrame, text="Acknowledge", command=lambda: var2.set(1), font=("Cambria", 14), fg="white", bg="green")
                removePairsButton.grid(pady=80)
                removePairsButton.wait_variable(var2) #computer "informs" player that its pairs are being removed before turns switch
                self.pairRemover(self.deck)
                random.shuffle(self.deck)
                self.turn=0
        self.endGame()

    #Removes all of the player's initial pairs and begins the game
    def startGame(self):
        self.pairRemover(self.deck)
        self.pairRemover(self.playerDeck)
        self.playGame()