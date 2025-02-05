extends Node2D

var c = cardFunctions.new()
var baseCard
var deck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	deck = c.generateStandardDeck()
	baseCard = load("res://cardScene.tscn")
	
	print("Main Scene ready")
	
	drawCard()


func _on_button_pressed() -> void:
	drawCard()

func drawCard():
	var card = baseCard.instantiate()
	var drawn = c.popRandomCard(deck)
	var vp = get_viewport()
	
	card = c.setupCardNode(card, drawn, Vector2(randi_range(0, vp.size.x), randi_range(0, vp.size.y)))
	
	add_child(card)
