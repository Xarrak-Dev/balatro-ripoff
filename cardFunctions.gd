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
		for r in 14:
			if r != 0:
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

func evaluate_poker_hand(cards: Array) -> String:
	var ranks = []
	var suits = []
	for card in cards:
		ranks.append(card.rank)
		suits.append(card.suit)
	
	var sorted_ranks = ranks.duplicate()
	sorted_ranks.sort()
	var rank_counts = _get_rank_counts(ranks)
	var is_flush = _check_flush(suits)
	var is_straight = _check_straight(ranks)
	
	if 5 in rank_counts.values() and is_flush:
		return "Flush Five"
	

	# Check for Flush House (Full House + Flush)
	if (3 in rank_counts.values() and 2 in rank_counts.values()) and is_flush:
		return "Flush House"
	
	# Check for Five of a Kind
	if 5 in rank_counts.values():
		return "Five of a Kind"
	
	# Check for Royal Flush
	if is_flush and is_straight:
		if sorted_ranks[0] == 10 and sorted_ranks[4] == 14:
			return "Royal Flush"
		else:
			return "Straight Flush"
	
	# Check for Four of a Kind
	if 4 in rank_counts.values():
		return "Four of a Kind"
	
	# Check for Full House
	if 3 in rank_counts.values() and 2 in rank_counts.values():
		return "Full House"
	
	# Check for Flush
	if is_flush:
		return "Flush"
	
	# Check for Straight
	if is_straight:
		return "Straight"
	
	# Check for Three of a Kind
	if 3 in rank_counts.values():
		return "Three of a Kind"
	
	# Check for Two Pair
	var pairs = 0
	for count in rank_counts.values():
		if count == 2:
			pairs += 1
	if pairs >= 2:
		return "Two Pair"
	
	# Check for One Pair
	if 2 in rank_counts.values():
		return "One Pair"  
	# Default to High Card
	return "High Card"

func _get_rank_counts(ranks: Array) -> Dictionary:
	var counts = {}
	for rank in ranks:
		counts[rank] = counts.get(rank, 0) + 1
	return counts

func _check_flush(suits: Array) -> bool:
	var first_suit = suits[0]
	for suit in suits:
		if suit != first_suit:
			return false
	return true

func _check_straight(ranks: Array) -> bool:
	var sorted_ranks = ranks.duplicate()
	sorted_ranks.sort()
	
	# Check for duplicates
	for i in range(len(sorted_ranks) - 1):
		if sorted_ranks[i] == sorted_ranks[i + 1]:
			return false
	
	# Check normal straight
	if sorted_ranks[-1] - sorted_ranks[0] == 4:
		return true
	
	# Check Ace-low straight (e.g., A-2-3-4-5)
	if sorted_ranks == [2, 3, 4, 5, 14]:
		return true
	
	return false
