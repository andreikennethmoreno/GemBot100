extends CharacterBody2D

@export var speed = 30
var player_position
var target_position

@onready var player = get_parent().get_parent().get_node("player")
@onready var game_manager = %GameManager

func _physics_process(delta):
	if game_manager.score > 90:
		player_position = player.position
		target_position = (player_position - position).normalized()
		
		if position.distance_to(player_position) > 3:
			# Move towards gem_position with speed
			move_and_collide(target_position * speed * delta)
			look_at(player_position)
