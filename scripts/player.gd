extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const GRAVITY = Vector2(0, 980.0)

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

@onready var coyote_timer: Timer = $CoyoteTimer
var coyote_time_active: bool = false

@onready var jump_buffer_timer: Timer = $JumpBufferTimer

var is_dead: bool = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += GRAVITY * delta

	var direction := Input.get_axis("left", "right")
	
	if not is_dead:
		if direction > 0:
			animated_sprite.flip_h = false
		elif direction < 0:
			animated_sprite.flip_h = true
		
		if is_on_floor():
			if direction == 0:
				animated_sprite.play("idle")
			else:
				animated_sprite.play("run")
			
			if coyote_time_active:
				coyote_time_active = false
				coyote_timer.stop()
		elif not is_on_floor():
			animated_sprite.play("jump")
			if not coyote_time_active:
				coyote_timer.start()
				coyote_time_active = true
				
		if Input.is_action_just_pressed("jump"):
			jump_buffer_timer.start()

			
		if not jump_buffer_timer.is_stopped() and (not coyote_timer.is_stopped() or is_on_floor()):
			velocity.y = JUMP_VELOCITY
			coyote_timer.stop()
			coyote_time_active = true
			
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
