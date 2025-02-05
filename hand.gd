extends Node2D

const SPACING = 150
const HAND_Y = 1000

var screen_center_x
var hand = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_center_x = get_viewport().size.x / 2


func add_card(card):
	hand.insert(hand.size(), card)
	update_hand_position()

func update_hand_position():
	for i in range(hand.size()):
		var new_pos = Vector2(calculate_position(i), HAND_Y)
		var card = hand[i]
		var tween = get_tree().create_tween()
		tween.tween_property(card, "position", new_pos, 0.05)

func calculate_position(index):
	var x_offset = (hand.size() - 1) * SPACING
	var x_pos = screen_center_x + index * SPACING - x_offset / 2
	return x_pos
