extends RigidBody2D

onready var world = $"../"

var random = RandomNumberGenerator.new() 

func _ready():
	random.randomize()
	
func _physics_process(delta):
	pass
	
func fireLeft(power):
	world.spawnTrash($openingLeft.global_position, power*Vector2(-1,getRandomYoffset()))
	
func fireTopLeft(power):
	world.spawnTrash($openingTopLeft.global_position, power*Vector2(-1,-1+getRandomYoffset()))



func getRandomPower():
	return random.randf_range(500, 1000)
func getRandomYoffset():
	return random.randf_range(-0.5, 0.5)

func _on_firingTimer_timeout():
	fireTopLeft(getRandomPower())

