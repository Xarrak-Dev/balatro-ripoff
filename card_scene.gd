extends Node2D

signal hovered
signal hovered_off
signal reselected
signal unselected

@onready var rankLabels = $rankLabels
@onready var suitLabels = $suitLabels
const c = preload("res://cardFunctions.gd")

var in_slot = false
var selected:bool = false
var mouseDown
var rank:int = 0
var suit:String = "error"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Card instantiated with data: rank = " + str(rank) + " suit = " + suit)
	for child in rankLabels.get_children():
		child.text = str(rank)
	for child in suitLabels.get_children():
		child.text = suit
	get_parent().connect_card_signals(self)

func _on_area_2d_mouse_entered() -> void:
	hovered.emit(self)

func _on_area_2d_mouse_exited() -> void:
	hovered_off.emit(self)

func select(_selected):
	selected = _selected
	var tween = get_tree().create_tween()
	if selected:
		tween.tween_property(self, "scale", Vector2(1, 1.2), 0.05)
		reselected.emit(self)
	else:
		tween.tween_property(self, "scale", Vector2(1, 1), 0.05)
		unselected.emit(self)

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if !event.pressed:
			select(not selected)
