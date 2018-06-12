import numpy as np
import random

class Card(object):
    """
    A single card in a deck.
    """
    def __init__(self, value, suit):
        self.value = value
        self.suit = suit

class Deck(object):
    """
    A regular deck of 52 playing cards.
    """

    def __init__(self):
      """
      Create a standard 52 playing card deck.
      """

      cards = []
      for suit in ['heart','club','diamond','spade']:
          for value in ['Ace','2','3','4','5','6','7','8','9','10','Jack','Queen','King']:
              cards.append(Card(value,suit))

      self.cards = cards

    @property
    def size (self):
        return len(self.cards)


    def shuffle(self):
      """
      Shuffle the deck.
      """ 
      random.shuffle(self.cards)

    def deal(self,number,player):
      """
      Deals 'number' of cards to the person who hits.
      """
      
      for card in range(number):
        self.shuffle()
        player.hand.append(self.cards.pop())
        if player.player_type == 'player':
          print ("Your card is the {} of {}s.".format(player.hand[-1].value, player.hand[-1].suit))

class Player(object):
    """
    A blackjack player.
    """

    def __init__(self,player_type):
      self.hand = []
      self.player_type = player_type

    @property
    def total (self):
        handtot = 0
        acetot = 0
        for card in self.hand:
          if card.value in ['Jack','Queen','King']:
            handtot += 10
          elif card.value is 'Ace':
            acetot += 1
          else:
            handtot += int(card.value)    
        for ace in range(acetot):
          if ace is acetot - 1: 
            if handtot >= 11:
              handtot += 1
            else:
              handtot += 11
          else:
              handtot += 1
        return handtot

    def check_hand(self):
      print ("Your cards are:")
      for card in self.hand:
        print ("{} of {}s.".format(card.value, card.suit))

    def hit(self,deck):
      """
      Deal 1 card to this player from the deck.
      """
      deck.deal(1,self)
      if self.player_type is 'dealer':
        print ("The dealer hits the {} of {}s. His total is {}.".format(self.hand[-1].value, self.hand[-1].suit,self.total))

class Game(object):
    """
    Play a game of blackjack!
    """

    def __init__(self,deck):
      
      """
      Initialize dealer and player and use the current deck.
      """
      dealer = Player('dealer')
      player = Player('player')

      #replace deck if lower than thirty cards, to discourage card counting.
      if deck.size < 30:
           print ("Deck getting low - replacing deck.")
           deck.__init__()

      #First, deal to dealer.
      
      deck.deal(2,dealer)
      print ("The dealer's face up card is the {} of {}s.".format(dealer.hand[-1].value, dealer.hand[-1].suit))

      #Now, deal to player.
      deck.deal(2,player)
      #Did you hit blackjack? If yes, congratulations, you win! If not, give the option to hit or stay.
      if player.total == 21:
        print ("Blackjack! You win!")
        return

      #initialize the 'stay' variable as false until the player is done hitting.
      stay = False
       
      while stay is False:
        print ("Your total is {}.".format(player.total))
        prompt = "Would you like to hit or stay? (h/s)"
        command = raw_input(prompt)
        if command not in ['h','s']:
          print ("I didn't understand that. Please print 'h' to hit or 's' to stay.")
        elif command is 'h':
          player.hit(deck)
          if player.total > 21 :
            print ("Bust! Your total is {}. The dealer wins.".format(player.total))
            return 
        elif command is 's':
          stay = True
    
      #Does dealer hit? Reveal face down card to check.
      print ("Dealer reveals face down card: the {} of {}s. His total is {}.".format(dealer.hand[0].value, dealer.hand[0].suit,dealer.total))
      while dealer.total < 17:
        dealer.hit(deck)

      #Now - who wins?
      if dealer.total > 21:
        print ("The dealer busts! His total is {}. You win!".format(dealer.total))
      else:
        print ("The dealer stays.")
        print ("Your total is {}. The dealer's total is {}.".format(player.total,dealer.total))
        if dealer.total >= player.total:
          print ("The dealer wins.")
        elif player.total > dealer.total:
          print ("You win!")


# to add - insurance, multiple ace, splitting cards
