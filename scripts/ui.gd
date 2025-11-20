extends CanvasLayer

@onready var label: Label = %Label
@onready var animation_player: AnimationPlayer = $Control/ColorRect/AnimationPlayer
@onready var color_rect: ColorRect = $Control/ColorRect

var coins = 0

func update_coins(value):
	coins += value
	uptade_coins_label()
	
func uptade_coins_label():
	label.text = str(coins)
