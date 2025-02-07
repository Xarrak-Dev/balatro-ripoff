extends Node

var chips:float
var multiplier:float
@onready var chipsLabel = $"../chips"
@onready var multLabel = $"../mult"
var baseHandScores:Dictionary = {"High Card":{"chips":5, "mult":1}, "One Pair":{"chips":10, "mult":2}, "Two Pair":{"chips":20, "mult":2}, "Three of a Kind":{"chips":30, "mult":3}, "Straight":{"chips":30, "mult":4}, "Flush":{"chips":35, "mult":4}, "Full House":{"chips":40, "mult":4}, "Four of a Kind":{"chips":60, "mult":7}, "Straight Flush":{"chips":100, "mult":8}, "Royal Flush":{"chips":100, "mult":8}, "Five of a Kind":{"chips":120, "mult":12}, "Flush House":{"chips":140, "mult":14}, "Flush Five":{"chips":160, "mult":16}}

func _ready() -> void:
	pass # Replace with function body.

func evaluateScore(hand):
	chips = baseHandScores[hand]["chips"]
	multiplier = baseHandScores[hand]["mult"]
	updateLabels()

func updateLabels():
	chipsLabel.text = str(chips)
	multLabel.text = str(multiplier)
