extends Node2D

@onready var hearts_container = $heartsContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	hearts_container.setMaxHearts(GlobalHealth.max_health)
	hearts_container.updateHearts(GlobalHealth.current_health)
	GlobalHealth.healthChanged.connect(hearts_container.updateHearts)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
