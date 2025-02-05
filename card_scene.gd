@tool
extends Node2D


@onready var label = $Label
const c = preload("res://cardFunctions.gd")

var rank:int = 0
var suit:String = "Spades"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Card instantiated with data: rank = " + str(rank) + " suit = " + suit)
	label.text = str(rank) + " of " + suit
