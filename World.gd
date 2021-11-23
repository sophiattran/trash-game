extends Node2D

export (PackedScene) var Trash
export (PackedScene) var Bullet 
export (PackedScene) var RestartButton

onready var playerDeathSound = $PlayerDeath
onready var winSound = $WinSound
onready var game = $'/root/Game'
var monsterDead = false
var won = false

func _ready():
	randomize()
	$BGtheme.play()

func _physics_process(_delta):
	if get_tree().get_nodes_in_group("trash").size()==0 and monsterDead and !won: 
		won = true
		$BGtheme.stop()
		winSound.play()
		$DieTimer.start()
	
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

func restartGame():
	get_tree().reload_current_scene()

func _on_DieTimer_timeout():
	var restart = RestartButton.instance()
	#get_tree().paused = true
	game.add_child(restart)
	if won:
		get_node("/root/Game/RestartButton/WinGameOverScreen").visible = true
	else:
		get_node("/root/Game/RestartButton/LoseGameOverScreen").visible = true
