extends RigidBody2D

onready var player = $"../Player" #move up the node tree one level and access Player node
onready var gauge = $'/root/Game/CanvasLayer/GUI/HBoxContainer/Bar/Gauge'
onready var soda = $Soda
onready var banana = $Banana

var colliding_with_player = false

func _ready():
	random_sprite()
	add_to_group("trash")

func _physics_process(delta):
	if position.y > 1000: queue_free() #remove self from scene after falling into the void

func fly_towards(pos, attraction_vector):
	var distance = position.distance_to(pos)
	var distance_to_player = position.distance_to(player.position)
	if  distance < 600 and distance_to_player > 180: #check distance from muzzle and distance from player
		var dir_vector = (position - pos).normalized()
		var degree = abs(rad2deg(dir_vector.angle_to(attraction_vector))) 
		if degree>=0 and degree<45: #the range of effect = 90 degrees
			apply_impulse(Vector2.ZERO, -dir_vector*10)
			if distance < 90:
				#increase energy bar here
				gauge.update_energy_bar(5)
				queue_free() 

func random_sprite():
	var sprite_num = randi() % 2
	if sprite_num == 0: 
		soda.visible = true
	elif sprite_num == 1:
		banana.visible = true


