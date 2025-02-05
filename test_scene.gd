extends Node2D

const COLLISION_MASK_CARD = 1
const COLLISION_MASK_SLOT = 2

var screen_size
var card_being_dragged
var is_hovering_on_card
var card_preview

var player
var c = cardFunctions.new()
var baseCard
var deck

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var hand = $'Hand'
	screen_size = get_viewport_rect().size
	deck = c.generateStandardDeck()
	baseCard = load("res://cardScene.tscn")
	
	var card = baseCard.instantiate()
	card = c.setupCardNode(card, c.popRandomCard(deck), Vector2(get_viewport().size.x / 2, 1080))
	hand.add_card(card)
	
	print("Main Scene ready")

func _process(delta: float) -> void:
	if card_being_dragged:
		var mouse_pos = get_global_mouse_position()
		var tween = get_tree().create_tween()
		tween.tween_property(card_being_dragged, "position", Vector2(clamp(mouse_pos.x, 0, screen_size.x), clamp(mouse_pos.y, 0, screen_size.y)), 0.02)

func drawCard():
	var card = baseCard.instantiate()
	var drawn = c.popRandomCard(deck)
	var vp = get_viewport()

func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycast_check_for_card()
			if card:
				start_drag(card)
		else:
			if card_being_dragged:
				finish_drag()

# Card dragging functions
func start_drag(card):
	card_being_dragged = card
	var tween = get_tree().create_tween()
	tween.tween_property(card, "scale", Vector2(1, 1), 0.05)

func finish_drag():
	var p_hand = $Hand
	var tween = get_tree().create_tween()
	tween.tween_property(card_being_dragged, "scale", Vector2(1.05, 1.05), 0.05)
	card_being_dragged.z_index = 1
	p_hand.update_hand_position()
	card_being_dragged = null

# Card hover effect functions
func on_hovered_over_card(card):
	if !is_hovering_on_card:
		is_hovering_on_card = true
		highlight_card(card, true)

func on_hovered_off(card):
	highlight_card(card, false)
	var new_card = raycast_check_for_card()
	if new_card:
		highlight_card(new_card, true)
	else:
		is_hovering_on_card = false

func highlight_card(card, hovered):
	if hovered and not card_being_dragged:
		var tween = get_tree().create_tween()
		tween.tween_property(card, "scale", Vector2(1.05, 1.05), 0.05)
		card.z_index = 2
	else:
		var tween = get_tree().create_tween()
		tween.tween_property(card, "scale", Vector2(1, 1), 0.05)
		card.z_index = 1

# Checks if the mouse is over a Card (or any element with a collision mask equal to COLLISION_MASK_CARD), and returns if it if there is
# this would be used as a variable, for example "var card = raycast_check_for_card()" and it will be null if did not find anything
func raycast_check_for_card():
	var space_state = get_world_2d().direct_space_state
	var perameters = PhysicsPointQueryParameters2D.new()
	perameters.position = get_global_mouse_position()
	perameters.collide_with_areas = true
	perameters.collision_mask = COLLISION_MASK_CARD
	var result = space_state.intersect_point(perameters)

	if result.size() > 0:
		return result[0].collider.get_parent()
	return null

# Connects the signals from the Area2D in the cards, so that they can be used in this script
func connect_card_signals(card):
	card.connect("hovered", on_hovered_over_card)
	card.connect("hovered_off", on_hovered_off)
