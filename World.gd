extends Node2D

export (PackedScene) var Trash
export (PackedScene) var Bullet 

onready var playerDeathSound = $PlayerDeath
onready var winSound = $WinSound
var monsterDead = false

func _ready():
	randomize()

func _physics_process(_delta):
	if get_tree().get_nodes_in_group("trash").size()==0 and monsterDead: winSound.play()

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

func _on_TestTimer_timeout():
	pass
