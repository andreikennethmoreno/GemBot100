extends Node

@export var max_health = 3
var current_health: int = max_health

signal healthChanged

func minus_health():
	current_health -= 1
	healthChanged.emit(current_health)
	print(current_health)

	if current_health == 0:
		to_main_menu()
		current_health = max_health

		
func to_main_menu():
		print("You died")
		get_tree().reload_current_scene()

