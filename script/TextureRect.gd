extends TextureRect

@onready var game_manager = %GameManager


func _ready():
	update_color()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func update_color():
	var score = game_manager.score

	if score < 0 or score > 100:
		return  # No color change if the score is out of bounds

	var start_hue = 30.0 / 360.0  # Brown/Orange hue normalized to 0-1
	var end_hue = 1.0  # Ending at Red, which is 1.0 in HSV

	var hue = start_hue + (end_hue - start_hue) * (score - 1) / 99.0  # Calculate hue based on score

	var color = Color.from_hsv(hue, 1, 1)  # Full saturation and brightness

	self.modulate = color

