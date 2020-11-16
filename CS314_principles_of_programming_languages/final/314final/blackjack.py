from tkinter import *
from PIL import ImageTk, Image
import os
import sys
import random
import time

class Application():
    def __init__(self):
        ###### Card Counting option - False makes the dealer use a multi-deck strategy to counter card counting, True makes the dealer use a single deck strategy which is easier for card counting
        self.card_counting = True
        ######
        if(sys.platform.startswith("win32")):
            self.platform = "windows"
        elif(sys.platform.startswith("linux")):
            self.platform = "linux"

        self.root = Tk()
        self.root.title('Blackjack')
        self.root.configure(background='green')
        if(self.platform == "windows"):
            self.root.state('zoomed')
        elif(self.platform == "linux"):
            self.root.state('normal')

        self.bs = IntVar()
        self.bs.set(1)
        #img = ImageTk.PhotoImage(Image.open("chip25.jpg"))
        #cardImg = Label(root, image = img)
        #cardImg.image = img
        #cardImg.pack()

        self.current_wager = 0
        self.balance = 200
        self.current_balance = StringVar()
        self.current_balance.set("Balance: " + str(self.balance))

        self.player_hand_value = StringVar()
        self.player_hand_value.set("Hand value: 0")
        #
        self.table_text_frame = Frame(self.root, bg="green")
        self.table_text_frame.place(relx=.475, rely=.25, anchor='n')
        self.blackjack_payout = Label(self.table_text_frame, bg="green", text="BLACKJACK PAYS 3 TO 2")
        self.blackjack_payout.config(font=("Cambria", 24), fg="white")
        self.blackjack_payout.pack()

        self.dealer_rules = Label(self.table_text_frame, bg="green", text="Dealer must stand on 17, and must draw to 16")
        self.dealer_rules.config(font=("Cambria", 24), fg="white")
        self.dealer_rules.pack()

        self.insurance_rules = Label(self.table_text_frame, bg="green", text="Insurance Pays 2 to 1")
        self.insurance_rules.config(font=("Cambria", 24), fg="white")
        self.insurance_rules.pack()
        #

        self.player_hand_frame = Frame(self.root, bg="green")
        self.player_hand_frame.place(relx=.475, rely=.99, anchor='s')

        self.player_hand_value_frame = Frame(self.root, bg="green")
        self.player_hand_value_frame.place(relx=.475, rely=.89, anchor='s')

        self.dealer_hand_frame = Frame(self.root, bg="green")
        self.dealer_hand_frame.place(relx=.475, rely=.01, anchor='n')

        self.hit_or_stand_frame = Frame(self.root, bg="green")
        self.hit_or_stand_frame.place(relx=.475, rely=.85, anchor='s')

        self.blackjack_options_frame = Frame(self.root, bg="green")
        #self.blackjack_options_frame.place(relx=.99, rely=.75, anchor='e')
        self.blackjack_options_frame.place(relx=.99, rely=.55, anchor='e')

        def rules(self, img):
            rules_window = Toplevel()
            rulesImg = Label(rules_window, image = img)
            rulesImg.pack()

        if(self.platform == "windows"):
            img_path = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "rules" + ".png"
        elif(self.platform == "linux"):
            img_path = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "rules" + ".png"

        img = ImageTk.PhotoImage(Image.open(img_path))
        rules_button = Button(self.root, text = "Rules", command=lambda:rules(self, img))
        rules_button.place(relx=.97, rely=.01)

        self.player_hand = dict()
        self.dealer_hand = dict()

        if self.card_counting == False:
            self.deck = Application.createMultiDeck(self)
        else:
            self.deck = Application.createSingleDeck(self)

        self.shuffled = Application.shuffle(self, self.deck, 0)

        Application.playGame(self)
        self.root.mainloop()

    def createMultiDeck(self):
        deck = {'2clubs1':'2', '2clubs2':'2', '2clubs3':'2', '2clubs4':'2', '2diamonds1':'2', '2diamonds2':'2', '2diamonds3':'2', '2diamonds4':'2', '2hearts1':'2', '2hearts2':'2', '2hearts3':'2', '2hearts4':'2', '2spades1':'2', '2spades2':'2', '2spades3':'2', '2spades4':'2', '3clubs1':'3', '3clubs2':'3', '3clubs3':'3', '3clubs4':'3', '3diamonds1':'3', '3diamonds2':'3', '3diamonds3':'3', '3diamonds4':'3', '3hearts1':'3', '3hearts2':'3', '3hearts3':'3', '3hearts4':'3', '3spades1':'3', '3spades2':'3', '3spades3':'3', '3spades4':'3', '4clubs1':'4', '4clubs2':'4', '4clubs3':'4', '4clubs4':'4', '4diamonds1':'4', '4diamonds2':'4', '4diamonds3':'4', '4diamonds4':'4', '4hearts1':'4', '4hearts2':'4', '4hearts3':'4', '4hearts4':'4', '4spades1':'4', '4spades2':'4', '4spades3':'4', '4spades4':'4', '5clubs1':'5', '5clubs2':'5', '5clubs3':'5', '5clubs4':'5', '5diamonds1':'5', '5diamonds2':'5', '5diamonds3':'5', '5diamonds4':'5', '5hearts1':'5', '5hearts2':'5', '5hearts3':'5', '5hearts4':'5', '5spades1':'5', '5spades2':'5', '5spades3':'5', '5spades4':'5', '6clubs1':'6', '6clubs2':'6', '6clubs3':'6', '6clubs4':'6', '6diamonds1':'6', '6diamonds2':'6', '6diamonds3':'6', '6diamonds4':'6', '6hearts1':'6', '6hearts2':'6', '6hearts3':'6', '6hearts4':'6', '6spades1':'6', '6spades2':'6', '6spades3':'6', '6spades4':'6', '7clubs1':'7', '7clubs2':'7', '7clubs3':'7', '7clubs4':'7', '7diamonds1':'7', '7diamonds2':'7', '7diamonds3':'7', '7diamonds4':'7', '7hearts1':'7', '7hearts2':'7', '7hearts3':'7', '7hearts4':'7', '7spades1':'7', '7spades2':'7', '7spades3':'7', '7spades4':'7', '8clubs1':'8', '8clubs2':'8', '8clubs3':'8', '8clubs4':'8', '8diamonds1':'8', '8diamonds2':'8', '8diamonds3':'8', '8diamonds4':'8', '8hearts1':'8', '8hearts2':'8', '8hearts3':'8', '8hearts4':'8', '8spades1':'8', '8spades2':'8', '8spades3':'8', '8spades4':'8', '9clubs1':'9', '9clubs2':'9', '9clubs3':'9', '9clubs4':'9', '9diamonds1':'9', '9diamonds2':'9', '9diamonds3':'9', '9diamonds4':'9', '9hearts1':'9', '9hearts2':'9', '9hearts3':'9', '9hearts4':'9', '9spades1':'9', '9spades2':'9', '9spades3':'9', '9spades4':'9', '10clubs1':'10', '10clubs2':'10', '10clubs3':'10', '10clubs4':'10', '10diamonds1':'10', '10diamonds2':'10', '10diamonds3':'10', '10diamonds4':'10', '10hearts1':'10', '10hearts2':'10', '10hearts3':'10', '10hearts4':'10', '10spades1':'10', '10spades2':'10', '10spades3':'10', '10spades4':'10', 'jackclubs1':'10', 'jackclubs2':'10', 'jackclubs3':'10', 'jackclubs4':'10', 'jackdiamonds1':'10', 'jackdiamonds2':'10', 'jackdiamonds3':'10', 'jackdiamonds4':'10', 'jackhearts1':'10', 'jackhearts2':'10', 'jackhearts3':'10', 'jackhearts4':'10', 'jackspades1':'10', 'jackspades2':'10', 'jackspades3':'10', 'jackspades4':'10', 'queenclubs1':'10', 'queenclubs2':'10', 'queenclubs3':'10', 'queenclubs4':'10', 'queendiamonds1':'10', 'queendiamonds2':'10', 'queendiamonds3':'10', 'queendiamonds4':'10', 'queenhearts1':'10', 'queenhearts2':'10', 'queenhearts3':'10', 'queenhearts4':'10', 'queenspades1':'10', 'queenspades2':'10', 'queenspades3':'10', 'queenspades4':'10', 'kingclubs1':'10', 'kingclubs2':'10', 'kingclubs3':'10', 'kingclubs4':'10', 'kingdiamonds1':'10', 'kingdiamonds2':'10', 'kingdiamonds3':'10', 'kingdiamonds4':'10', 'kinghearts1':'10', 'kinghearts2':'10', 'kinghearts3':'10', 'kinghearts4':'10', 'kingspades1':'10', 'kingspades2':'10', 'kingspades3':'10', 'kingspades4':'10', 'aceclubs1':'ace', 'aceclubs2':'ace', 'aceclubs3':'ace', 'aceclubs4':'ace', 'acediamonds1':'ace', 'acediamonds2':'ace', 'acediamonds3':'ace', 'acediamonds4':'ace', 'acehearts1':'ace', 'acehearts2':'ace', 'acehearts3':'ace', 'acehearts4':'ace', 'acespades1':'ace', 'acespades2':'ace', 'acespades3':'ace', 'acespades4':'ace'}
        return deck

    def createSingleDeck(self):
        deck = {'2clubs1':'2', '2diamonds1':'2','2hearts1':'2','2spades1':'2','3clubs1':'3','3diamonds1':'3','3hearts1':'3','3spades1':'3','4clubs1':'4','4diamonds1':'4','4hearts1':'4','4spades1':'4','5clubs1':'5','5diamonds1':'5','5hearts1':'5','5spades1':'5','6clubs1':'6','6diamonds1':'6', '6hearts1':'6','6spades1':'6','7clubs1':'7','7diamonds1':'7','7hearts1':'7','7spades1':'7','8clubs1':'8','8diamonds1':'8','8hearts1':'8','8spades1':'8','9clubs1':'9','9diamonds1':'9','9hearts1':'9','9spades1':'9','10clubs1':'10','10diamonds1':'10','10hearts1':'10','10spades1':'10','jackclubs1':'10','jackdiamonds1':'10','jackhearts1':'10','jackspades1':'10','queenclubs1':'10','queendiamonds1':'10','queenhearts1':'10','queenspades1':'10','kingclubs1':'10','kingdiamonds1':'10','kinghearts1':'10','kingspades1':'10','aceclubs1':'ace','acediamonds1':'ace','acehearts1':'ace','acespades1':'ace'}
        return deck

    def cleanup(self):
        for x in list(self.player_hand.keys()):
            self.player_hand.pop(x)
        for x in list(self.dealer_hand.keys()):
            self.dealer_hand.pop(x)
        for widget in self.player_hand_frame.winfo_children():
            widget.destroy()
        for widget in self.dealer_hand_frame.winfo_children():
            widget.destroy()
        for widget in self.hit_or_stand_frame.winfo_children():
            widget.destroy()
        for widget in self.player_hand_value_frame.winfo_children():
            widget.destroy()
        for widget in self.blackjack_options_frame.winfo_children():
            widget.destroy()
        self.play_again_button.destroy()
        self.player_hand_value.set("Hand value: 0")

    def blackjack(self,hand):
        if('ace' in list(hand.values()) and '10' in list(hand.values()) and len(hand) == 2):
            return True
        else:
            return False

    def determine_winner(self, insurance=False, even_money=False, double_down=False):
        player_total = Application.get_hand_value(self, self.player_hand)
        dealer_total = Application.get_hand_value(self, self.dealer_hand)

        for widget in self.blackjack_options_frame.winfo_children():
            widget.destroy()

        balance_before = self.balance

        if even_money == False and insurance == False:
            if Application.blackjack(self, self.player_hand) == True and Application.blackjack(self, self.dealer_hand) == False:
                self.balance+=(self.current_wager*1.5)
                #player has blackjack and dealer does not
            elif dealer_total > 21:
                self.balance+=self.current_wager
                #player wins - dealer bust
            elif Application.blackjack(self, self.player_hand) == True and Application.blackjack(self, self.dealer_hand) == True:
                pass
                #both have blackjack, no change in balance
            elif player_total > dealer_total and player_total <= 21:
                self.balance+=self.current_wager
                #player wins - better score
            elif player_total == dealer_total:
                pass
                #push
            else:
                self.balance-=self.current_wager
                #dealer wins
        elif even_money == True:
            self.balance+=self.current_wager
        elif insurance == True:
            card = next(iter(self.dealer_hand))
            if(self.platform == "windows"):
                img_path = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + card[0:-1] + ".gif"
            elif(self.platform == "linux"):
                img_path = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + card[0:-1] + ".GIF"
            img = ImageTk.PhotoImage(Image.open(img_path))
            cardImg = Label(self.dealer_hand_frame, image = img)
            cardImg.image = img
            cardImg.grid(column=0, row=0)

            if Application.blackjack(self, self.dealer_hand) == True:
                pass
            else:
                self.balance-=self.current_wager*1.5


        self.play_again_button = Button(self.root, text="Play again", command=lambda: self.bs.set(1))
        self.play_again_button.place(relx=.45, rely=.5)
        if balance_before < self.balance:
            self.play_again_button.config(text="You won $" + str(self.balance-balance_before) + ", play again?")
        elif balance_before == self.balance:
            self.play_again_button.config(text="Push, play again?")
        else:
            self.play_again_button.config(text="You lost $" + str(balance_before-self.balance) + ", play again?")

        self.root.wait_variable(self.bs)

        Application.cleanup(self)
        Application.playGame(self)

    def get_hand_value(self, hand):
        ace_count = 0
        hand_value = 0
        hand_keys = list(hand.values())
        for x in hand_keys:
            if(x == 'ace'):
                ace_count+=1
            else:
                hand_value += int(x)

        while(ace_count > 0):
            if(hand_value + 11 <= 21 and ace_count == 1):
                hand_value+=11
            else:
                hand_value+=1
            ace_count-=1

        return hand_value

    def shuffle(self, dictionary, n):
        for x in list(self.player_hand.keys()):
            dictionary.pop(x)
        for x in list(self.dealer_hand.keys()):
            dictionary.pop(x)
        keys = list(dictionary.keys())
        random.shuffle(keys)
        shfled = dict()
        for key in keys:
            shfled.update({key:dictionary[key]})
        return shfled

    def close(self, event):
        sys.exit()

    def playGame(self):

        def wager25():
            #global current_wager
            self.current_wager = 25
            wager25btn.destroy()
            wager50btn.destroy()
            wager100btn.destroy()
            Application.displayGame(self, self.root)

        def wager50():
            #global current_wager
            self.current_wager = 50
            wager25btn.destroy()
            wager50btn.destroy()
            wager100btn.destroy()
            Application.displayGame(self, self.root)

        def wager100():
            #global current_wager
            self.current_wager = 100
            wager25btn.destroy()
            wager50btn.destroy()
            wager100btn.destroy()
            Application.displayGame(self, self.root)

        wager25btn = Button(self.root, text="Bet 25", command=wager25, height=2, width=10)
        wager25btn.place(relx=0.4, rely=0.5)

        wager50btn = Button(self.root, text="Bet 50", command=wager50, height=2, width=10)
        wager50btn.place(relx=0.45, rely=0.5)

        wager100btn = Button(self.root, text="Bet 100", command=wager100, height=2, width=10)
        wager100btn.place(relx=0.50, rely=0.5)

    def hit(self, hand, dealer=False, double_down=False):
        #self.double_down_button.config(state="disabled")
        for widget in self.blackjack_options_frame.winfo_children():
            if(isinstance(widget, Button)):
                widget.config(state="disabled")
        if(len(self.shuffled) == 0):
            self.shuffled = Application.shuffle(self, self.deck, 0)
        card = next(iter(self.shuffled))

        if(self.platform == "windows"):
            img_path = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + card[0:-1] + ".gif"
            back_path = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + "back1.gif"
        elif(self.platform == "linux"):
            img_path = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + card[0:-1] + ".GIF"
            back_path = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + "back1.GIF"

        #img_path = Application.resource_path(self, card[0:-1] + ".gif")
        #print(img_path)

        hand[card] = self.shuffled[card]
        self.shuffled.pop(card)


        if len(self.dealer_hand) == 1 and dealer == True:
            img = ImageTk.PhotoImage(Image.open(back_path))
            #img = ImageTk.PhotoImage(Image.open(img_path))
            cardImg = Label(self.dealer_hand_frame, image = img)
            cardImg.image = img
            #cardImg.pack(side="left",padx=1)
            cardImg.grid(column=0, row=0)
        elif dealer == False:
            img = ImageTk.PhotoImage(Image.open(img_path))
            cardImg = Label(self.player_hand_frame, image = img)
            cardImg.image = img
            cardImg.pack(side="left",padx=1)
            #player_hand_value = "Hand value: " + str(get_hand_value(player_hand))
            self.player_hand_value.set("Hand value: " + str(self.get_hand_value(self.player_hand)))
        elif dealer == True:
            img = ImageTk.PhotoImage(Image.open(img_path))
            cardImg = Label(self.dealer_hand_frame, image = img)
            cardImg.image = img
            #cardImg.pack(side="left",padx=1)
            cardImg.grid(column=len(self.dealer_hand)-1, row=0, padx=1)

        if double_down == True:
            self.current_wager*=2

        if(Application.get_hand_value(self, self.player_hand) > 21):
            for widget in self.hit_or_stand_frame.winfo_children():
                widget.destroy()
            Application.determine_winner(self)
        elif(double_down == True):
            Application.stand(self)
        return hand

    def stand(self, double_down=False):      
        card = next(iter(self.dealer_hand))

        if(self.platform == "windows"):
            img_path = os.path.dirname(os.path.abspath(__file__)) + "\cards_and_chips\\" + card[0:-1] + ".gif"
        elif(self.platform == "linux"):
            img_path = os.path.dirname(os.path.abspath(__file__)) + "/cards_and_chips/" + card[0:-1] + ".GIF"

        img = ImageTk.PhotoImage(Image.open(img_path))
        cardImg = Label(self.dealer_hand_frame, image = img)
        cardImg.image = img
        cardImg.grid(column=0, row=0)

        for widget in self.hit_or_stand_frame.winfo_children():
            widget.destroy()

        for widget in self.blackjack_options_frame.winfo_children():
            widget.destroy()

        while(Application.get_hand_value(self, self.dealer_hand) <= 16):
            self.dealer_hand = Application.hit(self, self.dealer_hand, dealer=True)

        Application.determine_winner(self)

    def displayGame(self, root):
        self.player_hand = Application.hit(self, self.player_hand)
        self.dealer_hand = Application.hit(self, self.dealer_hand, True)
        self.player_hand = Application.hit(self, self.player_hand)
        self.dealer_hand = Application.hit(self, self.dealer_hand, True)

        #Automate a blackjack?
        #if(Application.blackjack(self, self.player_hand) == True):
        #    for widget in self.hit_or_stand_frame.winfo_children():
        #        widget.destroy()
        #    Application.determine_winner(self)

        #hit or stand buttons
        hit_button = Button(self.hit_or_stand_frame, text="Hit", command=lambda:Application.hit(self, self.player_hand), height=2, width=10)
        hit_button.pack(side="left", padx=30)

        stand_button = Button(self.hit_or_stand_frame, text="Stand", command=lambda:Application.stand(self), height=2, width=10)
        stand_button.pack(side="left", padx=30)

        player_hand_value_label = Label(self.player_hand_value_frame, bg="green", textvariable=self.player_hand_value)
        player_hand_value_label.config(font=("Cambria", 24), fg="white")
        player_hand_value_label.pack(side="top")



        current_balance_text = Label(self.blackjack_options_frame, text="Balance: " + str(self.balance))
        current_balance_text.pack(side="top", pady=10)

        self.double_down_button = Button(self.blackjack_options_frame, text="Double Down", command=lambda:Application.hit(self, self.player_hand, double_down=True))
        self.double_down_button.pack(side="top", pady=10)

        insurance_button = Button(self.blackjack_options_frame, text="Insurance",command=lambda:Application.determine_winner(self, insurance=True))
        insurance_button.pack(side="top", pady=10)
        test = list(self.dealer_hand.values())
        if(test[1] != 'ace'):
            insurance_button.config(state="disabled")

        even_money_button = Button(self.blackjack_options_frame, text="Even Money", command=lambda:Application.determine_winner(self, even_money=True))
        even_money_button.pack(side="top", pady=10)
        if(test[1] != 'ace' or not (Application.blackjack(self, self.player_hand))):
            even_money_button.config(state="disabled")
