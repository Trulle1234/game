extends Node2D

const SPEED = 60

var direction = 1

@onready var ray_cast_r: RayCast2D = $RayCastR
@onready var ray_cast_l: RayCast2D = $RayCastL

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_r.is_colliding():
		direction = -1
	elif ray_cast_l.is_colliding():
		direction = 1
	
	position.x += direction * SPEED * delta
