extends Area2D

@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

var next_level_path = ""

const FILE_BEGIN: String = "res://scenes/levels/level_"

func _on_body_entered(body: Node2D) -> void:
	var current_scene_file: String = get_tree().current_scene.scene_file_path
	var next_level_number = current_scene_file.to_int() + 1
	
	next_level_path = FILE_BEGIN + str(next_level_number) + ".tscn"
	
	body.is_dead = true
	body.velocity.x = 0
	animated_sprite.play("closed")
	audio_player.play()
	body.get_node("AnimatedSprite2D").play("invis")
	timer.start()

func _on_timer_timeout() -> void:
	if FileAccess.file_exists(next_level_path):
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().change_scene_to_file(FILE_BEGIN + "1.tscn")
