extends AnimatableBody2D

@onready var one_way_platform_3: AnimatableBody2D = $"."
@onready var one_way_platform_4: AnimatableBody2D = $"../OneWayPlatform4"

func _ready() -> void:
	one_way_platform_3.material.set_shader_parameter("active", true)
	one_way_platform_3.material.set_shader_parameter("active", true)
	one_way_platform_4.material.set_shader_parameter("active", true)
	one_way_platform_4.material.set_shader_parameter("active", true)
