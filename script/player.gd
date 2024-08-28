extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D


const SPEED = 300.0

func _physics_process(delta):
	var direction_x = Input.get_axis("left", "right")
	var direction_y = Input.get_axis("up", "down")

	# Set the animation based on input direction
	if direction_y < 0:
		animated_sprite.play("Up")
	elif direction_y > 0:
		animated_sprite.play("Down")
	else:
		animated_sprite.play("Idle")

	# Handle horizontal flipping
	if direction_x > 0:
		animated_sprite.flip_h = false
	elif direction_x < 0:
		animated_sprite.flip_h = true

	# Set the velocity based on input
	velocity.x = direction_x * SPEED
	velocity.y = direction_y * SPEED

	# Move the character
	move_and_slide()

 
