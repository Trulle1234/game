extends Node

var score = 0

@onready var score_label: Label = $ScoreLabel

func add_point():
	score += 1
	if score == 1:
		score_label.text = "Great Job! You Made it & collected 1 coin."
	else:
		score_label.text = "Great Job! You Made it & collected " + str(score) + " coins."
