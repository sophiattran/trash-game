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
	rotation_degrees -= 15
	if !vacuuming and Input.is_action_pressed("left_click"): vacuuming = true
	if Input.is_action_just_released("left_click"): vacuuming = false
	if Input.is_action_just_pressed("F") and gauge.health>=5: 
		world.spawnBullet(muzzle.global_position)
		gauge.update_energy_bar(-5)
		$ShootingSound.play()
		
	if vacuuming: 
		#if !$VacuumSound.is_playing(): 
		$VacuumSound.play()
		$AnimatedSprite.play("wind")
		var source_pos = muzzle.global_position
		get_tree().call_group("trash", "fly_towards", source_pos, (mouse_pos-source_pos).normalized())
	else:
		$AnimatedSprite.play("default")
		
func _on_Area2D_body_entered(body):
	if vacuuming and body.is_in_group("trash"): 
		gauge.update_energy_bar(5)
		body.set_collision_layer(0)
		body.queue_free()
