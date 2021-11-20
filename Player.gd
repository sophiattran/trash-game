extends KinematicBody2D

export (int) var run_speed = 300
export (int) var jump_speed = -1000
export (int) var gravity = 2000
export (int) var inertia =  50

const throw_speed = Vector2(2000, 0)

var velocity = Vector2()
var jumping = false
var trash = null

onready var gauge = $'/root/Game/CanvasLayer/GUI/HBoxContainer/Bar/Gauge'

func _ready():
	position.y = 100
	position.x = -2000
	$AnimatedSprite.play("idle")

func _physics_process(delta):
	get_movement_input()
	kinematic_rigid_interaction()
	
	velocity.y += gravity*delta 
	
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
	
	
	if jumping and is_on_floor():
		jumping = false

	if trash and Input.is_action_just_pressed("ui_accept"): 
		throw_trash() 
		
func kinematic_rigid_interaction():
	for index in get_slide_count(): 
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("trash"):
			collision.collider.apply_central_impulse(-collision.normal * inertia)

func get_movement_input():
	velocity.x = 0
	var right = Input.is_action_pressed("ui_right")
	var left = Input.is_action_pressed("ui_left")
	var jump = Input.is_action_just_pressed("ui_up")

	if jumping and jump and gauge.health>=20: 
		velocity.y = jump_speed
		gauge.update_energy_bar(-20)
	
	if jump and is_on_floor():
		jumping = true
		velocity.y = jump_speed
	if right:
		velocity.x = run_speed
	if left:
		velocity.x = -run_speed
	if velocity.x != 0:
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.flip_h = velocity.x < 0

func lift_trash(obj):
	$AnimatedSprite.play("lift")
	trash = obj

func throw_trash():
	trash.free_self()
	if $AnimatedSprite.flip_h:
		trash.apply_impulse(Vector2.ZERO, -throw_speed)
	else:
		trash.apply_impulse(Vector2.ZERO, throw_speed)
	trash = null
	$AnimatedSprite.play("idle")
