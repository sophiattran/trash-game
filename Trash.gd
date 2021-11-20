extends RigidBody2D

var mouse_over = false
var being_lifted = false
var applying_impulse = false
var rng = RandomNumberGenerator.new()

onready var player = $"../Player" #move up the node tree one level and access Player node
onready var gauge = $'/root/Game/CanvasLayer/GUI/HBoxContainer/Bar/Gauge'
onready var soda = $Soda
onready var banana = $Banana


func _ready():
	random_sprite()

func _physics_process(delta):
	if position.y > 1000: queue_free() #remove self from scene after falling into the void

	if mouse_over and Input.is_action_just_pressed("left_click"):
		throw_or_lift() 
	if being_lifted and applying_impulse:
		update_impulse()

func throw_or_lift():
	if being_lifted:
		player.throw_trash()
	else:
		if !player.trash: #limiting player's number of controlled objects to one
			player.lift_trash(self)
			being_lifted = true
			applying_impulse = true

func free_self():
	being_lifted = false
	applying_impulse = false
	$Timer.wait_time = 1

func update_impulse():
	var pos = player.position
	apply_impulse(Vector2.ZERO, (pos - position))
	applying_impulse = false
	$Timer.start()

func _on_Trash_mouse_entered():
	mouse_over = true
	$mouse_over.visible = true

func _on_Trash_mouse_exited():
	mouse_over = false
	$mouse_over.visible = false

func _on_Timer_timeout():
	applying_impulse = true
	var distance = position.distance_to(player.position)	
	$Timer.wait_time = distance / 4000
	
func fly_towards(pos, attraction_vector):
	var distance = position.distance_to(pos)
	if  distance < 600: #check distance first
		var dir_vector = (position - pos).normalized()
		var degree = abs(rad2deg(dir_vector.angle_to(attraction_vector))) 
		if degree>=0 and degree<45: #the range of effect = 90 degrees
			apply_impulse(Vector2.ZERO, -dir_vector*10)
			if distance < 250: 
				#increase energy bar here
				gauge.update_energy_bar(10)
				queue_free() 

func random_sprite():
	var sprite_num = randi() % 2
	if sprite_num == 0: 
		soda.visible = true
	elif sprite_num == 1:
		banana.visible = true
		
		

	
	
