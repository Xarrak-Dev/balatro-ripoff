extends Node2D

@onready var cardObj = preload("res://cardScene.tscn")

@onready var SPACING = cardObj.instantiate().find_child("Sprite2D").scale.x * 130
@onready var HAND_Y = get_viewport().size.y - 30
@onready var handLabel = $"../handType"
@onready var gamemgr = $"../GameManager"

var screen_center_x
var hand = []
var cardsSelected = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_center_x = get_viewport().size.x / 2

func cardSelect(card, selected:bool):
	if selected && cardsSelected.size() < 5:
		cardsSelected.append(card)
	elif !selected:
		cardsSelected.erase(card)
	elif cardsSelected.size() >= 5:
		return false
	var filledHand = cardsSelected.duplicate(true)
	if cardsSelected.size() < 5:
		for i in (5 - cardsSelected.size()):
			filledHand.append({"rank":0 - randf(), "suit":str(0 - randf())})
	var evalHand = cardFunctions.new().evaluate_poker_hand(filledHand)
	handLabel.text = evalHand
	gamemgr.evaluateScore(evalHand)
	return true

func add_card(card):
	hand.insert(hand.size(), card)
	update_hand_position()

func update_hand_position():
	for i in range(hand.size()):
		var new_pos = Vector2(calculate_position(i), HAND_Y)
		var card = hand[i]
		if not card.in_slot:
			var tween = get_tree().create_tween()
			tween.tween_property(card, "position", new_pos, 0.05)

func calculate_position(index):
	var x_offset = (hand.size() - 1) * SPACING
	var x_pos = screen_center_x + index * SPACING - x_offset / 2
	return x_pos
