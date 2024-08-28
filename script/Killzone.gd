extends Area2D


@onready var timer = $Timer
@onready var explosion = $explosion

@export var max_health = 3
@onready var current_health: int = max_health



func _on_body_entered(body):
	explosion.play()
	GlobalHealth.minus_health()
	#timer.start()

func _on_timer_timeout():
	explosion.play()
	get_tree().reload_current_scene()
