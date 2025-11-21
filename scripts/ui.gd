extends CanvasLayer

@onready var label: Label = %Label

var coins = 0

func update_coins(value):
	coins += value
	uptade_coins_label()
	
func uptade_coins_label():
	label.text = str(coins)
