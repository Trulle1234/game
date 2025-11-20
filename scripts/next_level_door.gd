extends Area2D

@onready var timer: Timer = $Timer
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var audio_player: AudioStreamPlayer2D = $AudioStreamPlayer2D

const FILE_BEGIN := "res://scenes/levels/level_"
var next_level_path := ""


func _on_body_entered(body: Node2D) -> void:
	var scene := get_tree().get_current_scene()
	if scene == null:
		return

	var scene_path: String = scene.scene_file_path
	var scene_name := scene_path.get_file().get_basename()  

	var level_number := 1
	if scene_name.begins_with("level_"):
		var parsed := scene_name.trim_prefix("level_")
		if parsed.is_valid_int():
			level_number = int(parsed)

	next_level_path = FILE_BEGIN + str(level_number + 1) + ".tscn"

	body.is_dead = true
	body.velocity.x = 0

	animated_sprite.play("closed")
	audio_player.play()

	var sprite := body.get_node("AnimatedSprite2D")
	if sprite:
		sprite.play("invis")

	timer.start()


func _on_timer_timeout() -> void:
	if FileAccess.file_exists(next_level_path):
		get_tree().change_scene_to_file(next_level_path)
	else:
		get_tree().change_scene_to_file(FILE_BEGIN + "1.tscn")
