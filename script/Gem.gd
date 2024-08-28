extends Area2D
var speed: float = 1000.0 
@onready var game_manager = %GameManager
@onready var snow_bat = $"../bats/snow_bat"
@onready var gem_sfx = $gem_sfx



var body_entered2 = false

# Define the boundaries
var min_x: float = -100.0
var max_x: float = 100.0
var min_y: float = -100.0
var max_y: float = 100.0

func _process(delta: float):
	if(body_entered2):
		change_position(delta)
	
func _ready():
	randomize()

func change_position(delta: float):
	var new_x: float = position.x + speed * delta * randf_range(-10, 10)
	var new_y: float = position.y + speed * delta * randf_range(-10, 10)

	position.x = clamp(new_x, min_x, max_x)
	position.y = clamp(new_y, min_y, max_y)
   


func _on_body_entered(body):
	body_entered2 = true
	if body.name == "player":
		print("this is a player")
		game_manager.add_point()
		gem_sfx.play()
	elif body.name == "snow_bat":
		snow_bat.hold_gem()


func _on_body_exited(body):
	body_entered2 = false
