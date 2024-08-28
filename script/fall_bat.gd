extends CharacterBody2D
@onready var timer = $Timer
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager

const speed = 60.0
const reset_duration = 10.0  # Duration for moving to reset position (in seconds)

# Define the boundaries
var min_x: float = -190.0
var max_x: float = 190.0
var min_y: float = -90.0
var max_y: float = 100.0

var falling: bool = false
var reset_target_position: Vector2 = Vector2.ZERO
var reset_start_position: Vector2 = Vector2.ZERO
var reset_start_time: float = 0.0

func _ready():
	
	print("Ready function called")
	# Initialize the bat's position
	reset_bat()

	timer.start()

func _physics_process(delta):
	if game_manager.score > 60:
		if falling:
			# Move the bat downwards while ensuring it stays within the y-boundaries
			if position.y < max_y:
				position.y += speed * delta
				animated_sprite.play("fall_fallBat")
			else:
				position.y = max_y
				reset_bat()

		elif position != reset_target_position:
			# Interpolate position to the reset target position
			print("Flying up to reset position...")
			animated_sprite.play("fly_fallBat")
			var elapsed_time = (Time.get_ticks_msec() / 1000.0) - reset_start_time
			var t = elapsed_time / reset_duration
			if t > 1.0:
				t = 1.0
			position = position.lerp(reset_target_position, t)

			# Check movement direction to flip sprite accordingly
			if reset_target_position.x > position.x:
				animated_sprite.flip_h = true  # Facing right
			else:
				animated_sprite.flip_h = false  # Facing left

			if position.distance_to(reset_target_position) < 1.0:
				position = reset_target_position
				print("Position reached!")
				animated_sprite.play("idle_fallBat")
				falling = false
				timer.start()



func reset_bat():
	print("Resetting bat position")
	reset_target_position = Vector2(randf_range(min_x, max_x), min_y)
	reset_start_position = position
	animated_sprite.play("idle_fallBat")
	reset_start_time = Time.get_ticks_msec() / 1000.0
	falling = false
	
	# Restart the time
	timer.start()

func _on_timer_timeout():
	# Set falling to true when the timer times out
	falling = true
