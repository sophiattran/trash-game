extends Sprite

signal vacuuming(position)

onready var gauge = $'/root/Game/CanvasLayer/GUI/HBoxContainer/Bar/Gauge'
onready var world = $'../../'
onready var muzzle = $muzzle
var vacuuming = false

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	rotation_degrees = 0
	look_at(mouse_pos)
	rotation_degrees -= 10
	if Input.is_action_pressed("left_click"): vacuuming = true
	if Input.is_action_just_released("left_click"): vacuuming = false
	if Input.is_action_just_pressed("F") and gauge.health>=5: 
		world.spawnBullet(muzzle.global_position)
		gauge.update_energy_bar(-5)
		
	if vacuuming: 
		get_tree().call_group("trash", "fly_towards", muzzle.global_position, (mouse_pos-muzzle.global_position).normalized())
		
