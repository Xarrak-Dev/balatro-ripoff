@tool
extends Node2D

signal hovered
signal hovered_off

@onready var rankLabels = $rankLabels
@onready var suitLabels = $suitLabels
const c = preload("res://cardFunctions.gd")

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
