from tkinter import *
from PIL import ImageTk, Image
from random import shuffle
import os
import sys
import random
import time

class Card:
	def __init__(self, suit, value, image):
		self.suit = suit
		self.value = value
		self.image = image
	def show(self):
		print(self.suit)
		print(self.value)
		print(self.image)
		print()

class Application():
	def __init__(self):
		self.window=Tk()
		self.window.title("War")
		self.window.configure(background='green')
		if(sys.platform == "linux"):
			self.window.state('normal')
		else:
			self.window.state('zoomed')

		self.computerFrame=Frame(self.window, bg = 'green')
		self.computerFrame.grid(row = 0, rowspan = 2, pady=125)

		self.centerFrame=Frame(self.window, bg = 'green')
		self.centerFrame.grid(row = 2, rowspan = 2, padx = 290, pady=25)

		self.playerFrame=Frame(self.window, bg = 'green')
		self.playerFrame.grid(row = 4, rowspan = 2, pady=125)

		self.images = []

		if(sys.platform == "linux"):
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
			self.images.append(self.clubs2)
			self.images.append(self.diamonds2)
			self.images.append(self.hearts2)
			self.images.append(self.spades2)

			self.path5 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "3clubs.GIF"
			self.clubs3= ImageTk.PhotoImage(Image.open(self.path5))
			self.path6 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "3diamonds.GIF"
			self.diamonds3= ImageTk.PhotoImage(Image.open(self.path6))
			self.path7 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "3hearts.GIF"
			self.hearts3= ImageTk.PhotoImage(Image.open(self.path7))
			self.path8 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "3spades.GIF"
			self.spades3= ImageTk.PhotoImage(Image.open(self.path8))
			self.images.append(self.clubs3)
			self.images.append(self.diamonds3)
			self.images.append(self.hearts3)
			self.images.append(self.spades3)

			self.path9 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "4clubs.GIF"
			self.clubs4= ImageTk.PhotoImage(Image.open(self.path9))
			self.path10 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "4diamonds.GIF"
			self.diamonds4= ImageTk.PhotoImage(Image.open(self.path10))
			self.path11 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "4hearts.GIF"
			self.hearts4= ImageTk.PhotoImage(Image.open(self.path11))
			self.path12 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "4spades.GIF"
			self.spades4= ImageTk.PhotoImage(Image.open(self.path12))
			self.images.append(self.clubs4)
			self.images.append(self.diamonds4)
			self.images.append(self.hearts4)
			self.images.append(self.spades4)

			self.path13 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "5clubs.GIF"
			self.clubs5= ImageTk.PhotoImage(Image.open(self.path13))
			self.path14 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "5diamonds.GIF"
			self.diamonds5= ImageTk.PhotoImage(Image.open(self.path14))
			self.path15 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "5hearts.GIF"
			self.hearts5= ImageTk.PhotoImage(Image.open(self.path15))
			self.path16 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "5spades.GIF"
			self.spades5= ImageTk.PhotoImage(Image.open(self.path16))
			self.images.append(self.clubs5)
			self.images.append(self.diamonds5)
			self.images.append(self.hearts5)
			self.images.append(self.spades5)

			self.path17 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "6clubs.GIF"
			self.clubs6= ImageTk.PhotoImage(Image.open(self.path17))
			self.path18 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "6diamonds.GIF"
			self.diamonds6= ImageTk.PhotoImage(Image.open(self.path18))
			self.path19 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "6hearts.GIF"
			self.hearts6= ImageTk.PhotoImage(Image.open(self.path19))
			self.path20 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "6spades.GIF"
			self.spades6= ImageTk.PhotoImage(Image.open(self.path20))
			self.images.append(self.clubs6)
			self.images.append(self.diamonds6)
			self.images.append(self.hearts6)
			self.images.append(self.spades6)

			self.path21 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "7clubs.GIF"
			self.clubs7= ImageTk.PhotoImage(Image.open(self.path21))
			self.path22 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "7diamonds.GIF"
			self.diamonds7= ImageTk.PhotoImage(Image.open(self.path22))
			self.path23 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "7hearts.GIF"
			self.hearts7= ImageTk.PhotoImage(Image.open(self.path23))
			self.path24 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "7spades.GIF"
			self.spades7= ImageTk.PhotoImage(Image.open(self.path24))
			self.images.append(self.clubs7)
			self.images.append(self.diamonds7)
			self.images.append(self.hearts7)
			self.images.append(self.spades7)

			self.path25 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "8clubs.GIF"
			self.clubs8= ImageTk.PhotoImage(Image.open(self.path25))
			self.path26 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "8diamonds.GIF"
			self.diamonds8= ImageTk.PhotoImage(Image.open(self.path26))
			self.path27 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "8hearts.GIF"
			self.hearts8= ImageTk.PhotoImage(Image.open(self.path27))
			self.path28 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "8spades.GIF"
			self.spades8= ImageTk.PhotoImage(Image.open(self.path28))
			self.images.append(self.clubs8)
			self.images.append(self.diamonds8)
			self.images.append(self.hearts8)
			self.images.append(self.spades8)

			self.path29 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "9clubs.GIF"
			self.clubs9= ImageTk.PhotoImage(Image.open(self.path29))
			self.path30 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "9diamonds.GIF"
			self.diamonds9= ImageTk.PhotoImage(Image.open(self.path30))
			self.path31 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "9hearts.GIF"
			self.hearts9= ImageTk.PhotoImage(Image.open(self.path31))
			self.path32 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "9spades.GIF"
			self.spades9= ImageTk.PhotoImage(Image.open(self.path32))
			self.images.append(self.clubs9)
			self.images.append(self.diamonds9)
			self.images.append(self.hearts9)
			self.images.append(self.spades9)

			self.path33 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "10clubs.GIF"
			self.clubs10= ImageTk.PhotoImage(Image.open(self.path33))
			self.path34 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "10diamonds.GIF"
			self.diamonds10= ImageTk.PhotoImage(Image.open(self.path34))
			self.path35 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "10hearts.GIF"
			self.hearts10= ImageTk.PhotoImage(Image.open(self.path35))
			self.path36 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "10spades.GIF"
			self.spades10= ImageTk.PhotoImage(Image.open(self.path36))
			self.images.append(self.clubs10)
			self.images.append(self.diamonds10)
			self.images.append(self.hearts10)
			self.images.append(self.spades10)

			self.path41 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "jackclubs.GIF"
			self.clubsjack= ImageTk.PhotoImage(Image.open(self.path41))
			self.path42 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "jackdiamonds.GIF"
			self.diamondsjack= ImageTk.PhotoImage(Image.open(self.path42))
			self.path43 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "jackhearts.GIF"
			self.heartsjack= ImageTk.PhotoImage(Image.open(self.path43))
			self.path44 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "jackspades.GIF"
			self.spadesjack= ImageTk.PhotoImage(Image.open(self.path44))
			self.images.append(self.clubsjack)
			self.images.append(self.diamondsjack)
			self.images.append(self.heartsjack)
			self.images.append(self.spadesjack)

			self.path45 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "queenclubs.GIF"
			self.clubsqueen= ImageTk.PhotoImage(Image.open(self.path45))
			self.path46 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "queendiamonds.GIF"
			self.diamondsqueen= ImageTk.PhotoImage(Image.open(self.path46))
			self.path47 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "queenhearts.GIF"
			self.heartsqueen= ImageTk.PhotoImage(Image.open(self.path47))
			self.path48 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "queenspades.GIF"
			self.spadesqueen= ImageTk.PhotoImage(Image.open(self.path48))
			self.images.append(self.clubsqueen)
			self.images.append(self.diamondsqueen)
			self.images.append(self.heartsqueen)
			self.images.append(self.spadesqueen)

			self.path49 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "kingclubs.GIF"
			self.clubsking= ImageTk.PhotoImage(Image.open(self.path49))
			self.path50 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "kingdiamonds.GIF"
			self.diamondsking= ImageTk.PhotoImage(Image.open(self.path50))
			self.path51 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "kinghearts.GIF"
			self.heartsking= ImageTk.PhotoImage(Image.open(self.path51))
			self.path52 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "kingspades.GIF"
			self.spadesking= ImageTk.PhotoImage(Image.open(self.path52))
			self.images.append(self.clubsking)
			self.images.append(self.diamondsking)
			self.images.append(self.heartsking)
			self.images.append(self.spadesking)

			self.path37 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "aceclubs.GIF"
			self.clubsace= ImageTk.PhotoImage(Image.open(self.path37))
			self.path38 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "acediamonds.GIF"
			self.diamondsace= ImageTk.PhotoImage(Image.open(self.path38))
			self.path39 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "acehearts.GIF"
			self.heartsace= ImageTk.PhotoImage(Image.open(self.path39))
			self.path40 = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "acespades.GIF"
			self.spadesace= ImageTk.PhotoImage(Image.open(self.path40))
			self.images.append(self.clubsace)
			self.images.append(self.diamondsace)
			self.images.append(self.heartsace)
			self.images.append(self.spadesace)

		elif(sys.platform == "win32"):
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
			self.images.append(self.clubs2)
			self.images.append(self.diamonds2)
			self.images.append(self.hearts2)
			self.images.append(self.spades2)

			self.path5 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "3clubs.gif"
			self.clubs3= ImageTk.PhotoImage(Image.open(self.path5))
			self.path6 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "3diamonds.gif"
			self.diamonds3= ImageTk.PhotoImage(Image.open(self.path6))
			self.path7 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "3hearts.gif"
			self.hearts3= ImageTk.PhotoImage(Image.open(self.path7))
			self.path8 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "3spades.gif"
			self.spades3= ImageTk.PhotoImage(Image.open(self.path8))
			self.images.append(self.clubs3)
			self.images.append(self.diamonds3)
			self.images.append(self.hearts3)
			self.images.append(self.spades3)

			self.path9 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "4clubs.gif"
			self.clubs4= ImageTk.PhotoImage(Image.open(self.path9))
			self.path10 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "4diamonds.gif"
			self.diamonds4= ImageTk.PhotoImage(Image.open(self.path10))
			self.path11 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "4hearts.gif"
			self.hearts4= ImageTk.PhotoImage(Image.open(self.path11))
			self.path12 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "4spades.gif"
			self.spades4= ImageTk.PhotoImage(Image.open(self.path12))
			self.images.append(self.clubs4)
			self.images.append(self.diamonds4)
			self.images.append(self.hearts4)
			self.images.append(self.spades4)

			self.path13 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "5clubs.gif"
			self.clubs5= ImageTk.PhotoImage(Image.open(self.path13))
			self.path14 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "5diamonds.gif"
			self.diamonds5= ImageTk.PhotoImage(Image.open(self.path14))
			self.path15 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "5hearts.gif"
			self.hearts5= ImageTk.PhotoImage(Image.open(self.path15))
			self.path16 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "5spades.gif"
			self.spades5= ImageTk.PhotoImage(Image.open(self.path16))
			self.images.append(self.clubs5)
			self.images.append(self.diamonds5)
			self.images.append(self.hearts5)
			self.images.append(self.spades5)

			self.path17 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "6clubs.gif"
			self.clubs6= ImageTk.PhotoImage(Image.open(self.path17))
			self.path18 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "6diamonds.gif"
			self.diamonds6= ImageTk.PhotoImage(Image.open(self.path18))
			self.path19 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "6hearts.gif"
			self.hearts6= ImageTk.PhotoImage(Image.open(self.path19))
			self.path20 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "6spades.gif"
			self.spades6= ImageTk.PhotoImage(Image.open(self.path20))
			self.images.append(self.clubs6)
			self.images.append(self.diamonds6)
			self.images.append(self.hearts6)
			self.images.append(self.spades6)

			self.path21 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "7clubs.gif"
			self.clubs7= ImageTk.PhotoImage(Image.open(self.path21))
			self.path22 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "7diamonds.gif"
			self.diamonds7= ImageTk.PhotoImage(Image.open(self.path22))
			self.path23 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "7hearts.gif"
			self.hearts7= ImageTk.PhotoImage(Image.open(self.path23))
			self.path24 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "7spades.gif"
			self.spades7= ImageTk.PhotoImage(Image.open(self.path24))
			self.images.append(self.clubs7)
			self.images.append(self.diamonds7)
			self.images.append(self.hearts7)
			self.images.append(self.spades7)

			self.path25 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "8clubs.gif"
			self.clubs8= ImageTk.PhotoImage(Image.open(self.path25))
			self.path26 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "8diamonds.gif"
			self.diamonds8= ImageTk.PhotoImage(Image.open(self.path26))
			self.path27 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "8hearts.gif"
			self.hearts8= ImageTk.PhotoImage(Image.open(self.path27))
			self.path28 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "8spades.gif"
			self.spades8= ImageTk.PhotoImage(Image.open(self.path28))
			self.images.append(self.clubs8)
			self.images.append(self.diamonds8)
			self.images.append(self.hearts8)
			self.images.append(self.spades8)

			self.path29 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "9clubs.gif"
			self.clubs9= ImageTk.PhotoImage(Image.open(self.path29))
			self.path30 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "9diamonds.gif"
			self.diamonds9= ImageTk.PhotoImage(Image.open(self.path30))
			self.path31 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "9hearts.gif"
			self.hearts9= ImageTk.PhotoImage(Image.open(self.path31))
			self.path32 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "9spades.gif"
			self.spades9= ImageTk.PhotoImage(Image.open(self.path32))
			self.images.append(self.clubs9)
			self.images.append(self.diamonds9)
			self.images.append(self.hearts9)
			self.images.append(self.spades9)

			self.path33 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "10clubs.gif"
			self.clubs10= ImageTk.PhotoImage(Image.open(self.path33))
			self.path34 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "10diamonds.gif"
			self.diamonds10= ImageTk.PhotoImage(Image.open(self.path34))
			self.path35 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "10hearts.gif"
			self.hearts10= ImageTk.PhotoImage(Image.open(self.path35))
			self.path36 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "10spades.gif"
			self.spades10= ImageTk.PhotoImage(Image.open(self.path36))
			self.images.append(self.clubs10)
			self.images.append(self.diamonds10)
			self.images.append(self.hearts10)
			self.images.append(self.spades10)

			self.path41 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "jackclubs.gif"
			self.clubsjack= ImageTk.PhotoImage(Image.open(self.path41))
			self.path42 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "jackdiamonds.gif"
			self.diamondsjack= ImageTk.PhotoImage(Image.open(self.path42))
			self.path43 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "jackhearts.gif"
			self.heartsjack= ImageTk.PhotoImage(Image.open(self.path43))
			self.path44 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "jackspades.gif"
			self.spadesjack= ImageTk.PhotoImage(Image.open(self.path44))
			self.images.append(self.clubsjack)
			self.images.append(self.diamondsjack)
			self.images.append(self.heartsjack)
			self.images.append(self.spadesjack)

			self.path45 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "queenclubs.gif"
			self.clubsqueen= ImageTk.PhotoImage(Image.open(self.path45))
			self.path46 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "queendiamonds.gif"
			self.diamondsqueen= ImageTk.PhotoImage(Image.open(self.path46))
			self.path47 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "queenhearts.gif"
			self.heartsqueen= ImageTk.PhotoImage(Image.open(self.path47))
			self.path48 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "queenspades.gif"
			self.spadesqueen= ImageTk.PhotoImage(Image.open(self.path48))
			self.images.append(self.clubsqueen)
			self.images.append(self.diamondsqueen)
			self.images.append(self.heartsqueen)
			self.images.append(self.spadesqueen)

			self.path49 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "kingclubs.gif"
			self.clubsking= ImageTk.PhotoImage(Image.open(self.path49))
			self.path50 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "kingdiamonds.gif"
			self.diamondsking= ImageTk.PhotoImage(Image.open(self.path50))
			self.path51 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "kinghearts.gif"
			self.heartsking= ImageTk.PhotoImage(Image.open(self.path51))
			self.path52 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "kingspades.gif"
			self.spadesking= ImageTk.PhotoImage(Image.open(self.path52))
			self.images.append(self.clubsking)
			self.images.append(self.diamondsking)
			self.images.append(self.heartsking)
			self.images.append(self.spadesking)

			self.path37 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "aceclubs.gif"
			self.clubsace= ImageTk.PhotoImage(Image.open(self.path37))
			self.path38 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "acediamonds.gif"
			self.diamondsace= ImageTk.PhotoImage(Image.open(self.path38))
			self.path39 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "acehearts.gif"
			self.heartsace= ImageTk.PhotoImage(Image.open(self.path39))
			self.path40 = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "acespades.gif"
			self.spadesace= ImageTk.PhotoImage(Image.open(self.path40))
			self.images.append(self.clubsace)
			self.images.append(self.diamondsace)
			self.images.append(self.heartsace)
			self.images.append(self.spadesace)



		self.suits = ["clubs", "diamonds", "hearts", "spades"]
		self.deck = [Card(suit, v, self.back) for v in range(2,15) for suit in self.suits] #creates a deck with a value and a suit, all face down.
		self.backOfCard = Card("doesnt matter", 0, self.back)



		for n in range(len(self.deck)):
			self.deck[n].image = self.images[n]

		shuffle(self.deck) #shuffles deck

		self.playerDeck = self.deck[0:26]
		self.otherDeck = self.deck[26:52]



		self.ccImage = Label(self.computerFrame, image=self.back)
		self.ccImage.grid(row = 0)

		self.ccImage = Label(self.playerFrame, image=self.back)
		self.ccImage.grid(row = 4)

		playLabel=Label(self.computerFrame, text="Computer has " + str(len(self.otherDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
		playLabel.grid(row = 0, column = 20)
		playLabel=Label(self.playerFrame, text="Player has " + str(len(self.playerDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
		playLabel.grid(row = 4, column = 10)

		self.playLabel=Label(self.centerFrame, text="Flip a card. Whoever has the higher card takes both and adds it to their deck.", font=("Cambria", 14), fg="white", bg = 'green')
		self.playLabel.grid(ipadx = 174, sticky = NW)
		self.flipFirstCard = Button(self.centerFrame, text="Flip Card", command=self.startGame, font=("Cambria", 14), fg="white", bg="green")
		self.flipFirstCard.grid(row = 2)

		self.window.mainloop()
		
	def warReset(self):
		for widget in self.centerFrame.winfo_children():
			widget.destroy()
		ccImage = Label(self.computerFrame, image=self.back)
		ccImage.grid(row = 0, sticky = NW)
		playLabel=Label(self.centerFrame, text="Flip a card. Whoever has the higher card takes both and adds it to their deck.", font=("Cambria", 14), fg="white", bg="green")
		playLabel.grid(ipadx = 174, sticky = NW)
		ccImage = Label(self.playerFrame, image=self.back)
		ccImage.grid(row = 4, sticky = NW)

	def frameReset(self):
		for widget in self.computerFrame.winfo_children():
			widget.destroy()
		for widget in self.centerFrame.winfo_children():
			widget.destroy()
		for widget in self.playerFrame.winfo_children():
			widget.destroy()
		#playerFrame.grid(padx=50, pady=25)
		ccImage = Label(self.computerFrame, image=self.back)
		ccImage.grid(row = 0, sticky = NW)
		#playLabel=Label(self.computerFrame, text="Computer has " + str(len(self.otherDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
		#playLabel.grid(row = 0, column = 20)

		ccImage = Label(self.playerFrame, image=self.back)
		ccImage.grid(row = 4, sticky = NW)
		#playLabel=Label(self.playerFrame, text="Player has " + str(len(self.playerDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
		#playLabel.grid(row = 4, column = 10)

		playLabel=Label(self.centerFrame, text="Flip a card. Whoever has the higher card takes both and adds it to their deck.", font=("Cambria", 14), fg="white", bg="green")
		playLabel.grid(ipadx = 174, sticky = NW)

	def gameOver(self, winner):
		self.computerFrame.destroy()
		self.centerFrame.destroy()
		self.playerFrame.destroy()
		if winner == 1:
			winLabel=Label(self.window, text="Computer wins! :(", font=("Cambria", 40), fg="white", bg="green")
			winLabel.grid(padx=500, pady=280)
		else:
			winLabel=Label(self.window, text="You win! :)", font=("Cambria", 40), fg="white", bg="green")
			winLabel.grid(padx=575, pady=280)
		exitButton= Button(self.window, text="Exit", command=sys.exit, font=("Cambria", 18), fg="white", bg="green")
		exitButton.grid()
		

	def play(self, playerDeck, otherDeck):
		winner = False
		self.frameReset()
		playLabel=Label(self.computerFrame, text="Computer has " + str(len(self.otherDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
		playLabel.grid(row = 0, column = 20)
		playLabel=Label(self.playerFrame, text="Player has " + str(len(self.playerDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
		playLabel.grid(row = 4, column = 10)
		shuffle(playerDeck)
		shuffle(otherDeck)

		while len(playerDeck) != 52 and len(otherDeck) != 52 and winner == False:
			playerCard = playerDeck[0]
			otherCard = otherDeck[0]
			playerDeck.pop(0)
			otherDeck.pop(0)

			ccImage=Label(self.computerFrame, image = otherCard.image)
			ccImage.grid(row = 0, column = 1)
			ccImage=Label(self.playerFrame, image = playerCard.image)
			ccImage.grid(row = 4, column = 1)

			cardsToAdd = []
			cardsToAdd.append(playerCard)
			cardsToAdd.append(otherCard)

			print("Player's card is " + str(playerCard.value))
			print("Other's card is " + str(otherCard.value))

			if playerCard.value == otherCard.value:				#if they have the same card value
				pickLabel = Label(self.centerFrame, text="War! Place the top card on your deck face down, and the next card face up. Whoever has the higher card wins the round", font=("Cambria", 14), fg="white", bg="green")
				pickLabel.grid()

				var1=IntVar()
				ackButton= Button(self.centerFrame, text="Acknowledge, and flip next card", command=lambda: var1.set(1), font=("Cambria", 14), fg="white", bg="green")
				ackButton.grid()
				ackButton.wait_variable(var1)
				#frameReset()
				if len(playerDeck) >= 2 and len(otherDeck) >=2: #if they have enough cards to have a war
					while playerCard.value == otherCard.value:	#as long as the card that they flip face up is the same	

						notImportantPlayerCard = playerDeck[0]
						notImportantOtherCard = otherDeck[0]
						playerDeck.pop(0)
						otherDeck.pop(0)

						playerCard = playerDeck[0]
						otherCard = otherDeck[0]
						playerDeck.pop(0)
						otherDeck.pop(0)

						ccImage=Label(self.computerFrame, image = self.back)
						ccImage.grid(row=0, column = 3)
						ccImage=Label(self.computerFrame, image = otherCard.image)
						ccImage.grid(row = 0, column = 4)

						ccImage=Label(self.playerFrame, image = self.back)
						ccImage.grid(row=4, column = 3)
						ccImage=Label(self.playerFrame, image = playerCard.image)
						ccImage.grid(row = 4, column = 4)
						self.warReset()

						cardsToAdd.append(playerCard)
						cardsToAdd.append(otherCard)
						cardsToAdd.append(notImportantPlayerCard)
						cardsToAdd.append(notImportantOtherCard)
				elif len(playerDeck) < 2 or len(otherDeck) < 2:
					winner = True

			if playerCard.value > otherCard.value:
				pickLabel = Label(self.centerFrame, text="Player has the higher card. Add all cards to the bottom of your deck.", font=("Cambria", 14), fg="white", bg="green")
				pickLabel.grid(ipadx = 208)

				for n in range(0, len(cardsToAdd)):
					playerDeck.append(cardsToAdd[n])

				playLabel=Label(self.computerFrame, text="Computer has " + str(len(self.otherDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
				playLabel.grid(row = 0, column = 20)
				playLabel=Label(self.playerFrame, text="Player has " + str(len(self.playerDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
				playLabel.grid(row = 4, column = 10)
				
				var1=IntVar()
				ackButton= Button(self.centerFrame, text="Acknowledge, and flip next card", command=lambda: var1.set(1), font=("Cambria", 14), fg="white", bg="green")
				ackButton.grid()
				ackButton.wait_variable(var1)
				
				self.frameReset()
				playLabel=Label(self.computerFrame, text="Computer has " + str(len(self.otherDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
				playLabel.grid(row = 0, column = 20)
				playLabel=Label(self.playerFrame, text="Player has " + str(len(self.playerDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
				playLabel.grid(row = 4, column = 10)
			elif playerCard.value < otherCard.value:
				pickLabel = Label(self.centerFrame, text="Computer has the higher card. All cards were added to the bottom of the deck.", font=("Cambria", 14), fg="white", bg="green")
				pickLabel.grid(ipadx = 167)
				
				for n in range(0, len(cardsToAdd)):
					otherDeck.append(cardsToAdd[n])

				playLabel=Label(self.computerFrame, text="Computer has " + str(len(self.otherDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
				playLabel.grid(row = 0, column = 20)
				playLabel=Label(self.playerFrame, text="Player has " + str(len(self.playerDeck)) + " cards", font=("Cambria", 14), fg="white", bg="green")
				playLabel.grid(row = 4, column = 10)
				
				var1=IntVar()
				ackButton= Button(self.centerFrame, text="Acknowledge, and flip next card", command=lambda: var1.set(1), font=("Cambria", 14), fg="white", bg="green")
				ackButton.grid()
				ackButton.wait_variable(var1)
				
				self.frameReset()
				
			print("Player has " + str(len(playerDeck)) + " cards.")
			print("Other has " + str(len(otherDeck)) + " cards.\n")
				
		if len(playerDeck) > len(otherDeck):
			self.gameOver(0)
		else:
			self.gameOver(1)

	def startGame(self):
		self.play(self.playerDeck, self.otherDeck)
	

#play(playerDeck,otherDeck)