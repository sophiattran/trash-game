extends Node2D

export (PackedScene) var Trash

func _ready():
	randomize()

func spawnTrash(pos, impulse): 
	var trash = Trash.instance()
	add_child(trash)
	trash.position = pos
	trash.apply_impulse(Vector2.ZERO, impulse)
	
	
	
	
