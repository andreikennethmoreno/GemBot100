extends CharacterBody2D

@export var speed = 120
var gem_position
var target_position

# Define the boundaries
var min_x: float = -220.0
var max_x: float = 220.0
var min_y: float = -100.0
var max_y: float = 100.0

var isHoldingGem = false

@onready var gem = get_parent().get_parent().get_node("Gem")
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager


func _ready():
	randomize()
	set_random_position()
	
func set_random_position():
	position.x = min_x
	position.y = randf_range(min_y, max_y)

func _process(delta):
	if (isHoldingGem):
		animated_sprite.play("gem_snow_bat")
	else: 
		animated_sprite.play("idle_snow_bat")


func _physics_process(delta):
	if  game_manager.score > 45:
		if(!isHoldingGem):
			gem_position = gem.position
			target_position = (gem_position - position).normalized()
			
			if position.distance_to(gem_position) > 3:
				# Move towards gem_position with speed
				move_and_collide(target_position * speed * delta)
		else: 
			speed = 70
			var new_x: float = position.x + speed * delta
			if new_x > max_x:
				isHoldingGem = false
				set_random_position()
				speed = 120
			else:
				position.x = new_x

func hold_gem():
	print("Holding gem")
	isHoldingGem = true


