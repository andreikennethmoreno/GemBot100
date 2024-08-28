extends Node

var score = 0
@onready var score_label = $ScoreLabel
@onready var texture_rect = $"../TextureRect"
@onready var advice = $Advice

func add_point():
	score += 1
	score_label.text = str(score)
	print(score)
	texture_rect.update_color()
	
func _process(delta):
	if score > 100: 
		advice.text = "Congrats lol"
