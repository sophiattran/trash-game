extends TextureProgress


# Declare member variables here. Examples:
export (int) var health = 0
onready var number = $'/root/Game/CanvasLayer/GUI/HBoxContainer/Bar/Count/Background/Number'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func update_energy_bar(amount):
	health += amount
	get_node('/root/Game/CanvasLayer/GUI/HBoxContainer/Bar/Gauge').set_value(health)
	number.update_text(amount)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
