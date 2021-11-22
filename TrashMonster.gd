extends RigidBody2D

onready var world = $"../"
export (PackedScene) var Nuke

var random = RandomNumberGenerator.new() 
var botLeftHealth = 100
var topLeftHealth = 100
var topRightHealth = 100
var botRightHealth = 100
var health = 100

func _ready():
	random.randomize()
	
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
func getRandomXoffset():
	return random.randf_range(-500, 500)

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

func launch_nuke():
	var nuke = Nuke.instance()
	world.add_child(nuke)
	nuke.position = $chimney.global_position
	nuke.apply_impulse(Vector2.ZERO, Vector2(getRandomXoffset(), -800))

func botLeft_low_health():
	if botLeftHealth <= 0:
		$bottomLeftCore/green_light.visible = false
		$bottomLeftCore/red_light.visible = true

func topLeft_low_health():
	if topLeftHealth <= 0:
		$topLeftCore/green_light.visible = false
		$topLeftCore/red_light.visible = true
		
func topRight_low_health():
	if topRightHealth <= 0:
		$topRightCore/green_light.visible = false
		$topRightCore/red_light.visible = true
		
func botRight_low_health():
	if botRightHealth <= 0:
		$botRightCore/green_light.visible = false
		$botRightCore/red_light.visible = true
		
