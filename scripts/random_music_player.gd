extends AudioStreamPlayer2D

@onready var timer: Timer = $Timer
@onready var player: AudioStreamPlayer2D = $"."

var tracks: Array[AudioStream] = [
	preload("res://assets/music/fast/Bright.mp3"),
	preload("res://assets/music/fast/Chimney.mp3"),
	preload("res://assets/music/fast/Deck .mp3"),
	preload("res://assets/music/fast/Family.mp3"),
	preload("res://assets/music/fast/Flight.mp3"),
	preload("res://assets/music/fast/Gifts.mp3"),
	preload("res://assets/music/fast/Holiday.mp3"),
	preload("res://assets/music/fast/Merry.mp3"),
	preload("res://assets/music/fast/Santa.mp3"),
	preload("res://assets/music/fast/Sleigh.mp3"),
]

var last_index: int = -1
var delay_between_tracks: float = 1.0 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	player.finished.connect(_on_player_finished)
	timer.timeout.connect(_on_timer_timeout)
	
	play_random_track(tracks)
	
func play_random_track(tracks) -> void:
	if tracks.is_empty(): return
	
	var idx: int = randi() % tracks.size()
	if tracks.size() > 1:
		var safety := 0
		while idx == last_index and safety < 10:
			idx = randi() % tracks.size()
			safety += 1
	
	last_index = idx
	player.stream = tracks[idx]
	player.play()

func _on_player_finished() -> void:
	timer.start(delay_between_tracks)
	
func _on_timer_timeout() -> void:
	play_random_track(tracks)
