class_name cardFunctions

func generateStandardDeck() -> Array:
	var suit
	var card:Dictionary
	var deck:Array
	for s in 4:
		if s == 0:
			suit = "Spades"
		elif s == 1:
			suit = "Clubs"
		elif s == 2:
			suit = "Diamonds"
		elif s == 3:
			suit = "Hearts"
		for r in 13:
			card = {"suit": suit, "rank": r + 1}
			deck.append(card)
	return deck

func popRandomCard(deck:Array) -> Dictionary:
	if deck.size() > 0:
		return deck.pop_at(randi_range(0, deck.size() - 1))
	return {"rank":0, "suit":"error"}

func setupCardNode(cardObject:Node2D, drawnCard:Dictionary, position:Vector2) -> Node2D:
	cardObject.rank = drawnCard.rank
	cardObject.suit = drawnCard.suit
	cardObject.position = position
	return cardObject
