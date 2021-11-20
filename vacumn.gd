extends Sprite

signal vacuuming(position)

var vacuuming = false

func _physics_process(delta):
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	rotation_degrees -= 10
	if Input.is_action_pressed("left_click"): vacuuming = true
	if Input.is_action_just_released("left_click"): vacuuming = false
	
	if vacuuming: 
		get_tree().call_group("trash", "fly_towards", global_position, (mouse_pos-global_position).normalized())
