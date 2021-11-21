extends RigidBody2D

onready var world = $"../"

var random = RandomNumberGenerator.new() 

func _ready():
	random.randomize()
	
func _physics_process(delta):
	pass
	
func fireLeft(power):
	world.spawnTrash($openingLeft.global_position, power*Vector2(-1,getRandomYoffset()))
	$ShootingSound.play()
func fireRight(power):
	world.spawnTrash($openingRight.global_position, power*Vector2(1,getRandomYoffset()))
	$ShootingSound.play()
func fireTopLeft(power):
	world.spawnTrash($openingTopLeft.global_position, power*Vector2(-1,-1+getRandomYoffset()))
	$ShootingSound.play()
func fireTopRight(power):
	world.spawnTrash($openingTopRight.global_position, power*Vector2(1,-1+getRandomYoffset()))
	$ShootingSound.play()

func getRandomPower(lower, upper):
	return random.randf_range(lower, upper)
func getRandomYoffset():
	return random.randf_range(-0.5, 0.5)

func _on_firingTimer_timeout():
	peaceful_mode()

func peaceful_mode():
	fireTopLeft(getRandomPower(500, 1200))
	fireTopRight(getRandomPower(500, 1200))
	fireRight(getRandomPower(500, 1200))
	fireLeft(getRandomPower(500, 1200))

func defensive_mode():
	fireTopLeft(getRandomPower(1000, 10000))
	fireTopRight(getRandomPower(1000, 10000))
	fireRight(getRandomPower(1000, 10000))
	fireLeft(getRandomPower(1000, 10000))	

func offensive_mode():
	pass


