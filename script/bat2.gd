extends Node2D



var speed: float = -50.0 
@onready var game_manager = %GameManager
@onready var animated_sprite = $AnimatedSprite2D

# Define the boundaries
var min_x: float = -220.0
var max_x: float = 220.0
var min_y: float = -100.0
var max_y: float = 100.0

# Movement variables
var target_y: float = 0.0
var move_duration: float = 10.0  # Increase time to slow down the movement
var elapsed_time: float = 0.0
var start_position: Vector2
var is_moving: bool = false

func _process(delta: float):
	animated_sprite.flip_h = true
	if game_manager.score > 30:
		if not is_moving:
			is_moving = true
			set_new_target()
		move_bat(delta)
		

func _ready():
	randomize()
	set_random_position()
	set_new_target()

func move_bat(delta: float):
	if is_moving:
		elapsed_time += delta
		var t: float = elapsed_time / move_duration
		if t >= 1.0:
			t = 1.0
			is_moving = false
			set_random_position()
			set_new_target()

		# Interpolate position
		position.x = lerp(start_position.x, min_x, t)
		position.y = lerp(start_position.y, target_y, t)

func set_random_position():
	position.x = max_x
	position.y = randf_range(min_y, max_y)

func set_new_target():
	elapsed_time = 0.0
	start_position = position
	target_y = randf_range(min_y, max_y)
	is_moving = true

# Linear interpolation function
func lerp(a: float, b: float, t: float) -> float:
	return a + (b - a) * t
