extends Node2D

export (PackedScene) var Trash
export (PackedScene) var Bullet 

func _ready():
	randomize()

func spawnTrash(pos, impulse): 
	var trash = Trash.instance()
	add_child(trash)
	trash.position = pos
	trash.apply_impulse(Vector2.ZERO, impulse)

func spawnBullet(pos):
	var bullet = Bullet.instance()
	add_child(bullet)
	bullet.position = pos 
	bullet.apply_impulse(Vector2.ZERO, (get_global_mouse_position()-pos).normalized()*2000)
