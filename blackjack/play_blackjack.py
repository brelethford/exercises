import blackjack as bj

deck = bj.Deck()
stop = False
while stop is False:
  bj.Game(deck)
  prompt = "Would you like to keep playing? (y/n)"
  command = raw_input(prompt)
  if command is 'n':
    stop = True

print ("Thanks for playing!")


