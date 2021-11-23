extends RigidBody2D

onready var world = $"../"
export (PackedScene) var Nuke

var random = RandomNumberGenerator.new() 
var botLeftHealth = 100
var topLeftHealth = 100
var topRightHealth = 100
var botRightHealth = 100
var health = 100
var botLeft_working = true
var botRight_working = true
var topLeft_working = true
var topRight_working = true

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
	var num = randi() % 2
	if num==0:return random.randf_range(-150, -400)
	return random.randf_range(150, 400)

func _on_firingTimer_timeout():
	peaceful_mode()

func peaceful_mode():
	if topLeft_working: fireTopLeft(getRandomPower(200, 1000))
	if topRight_working: fireTopRight(getRandomPower(200, 1000))
	if botRight_working: fireRight(getRandomPower(200, 1500))
	if botLeft_working: fireLeft(getRandomPower(200, 1500))

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
	$BombShootingSound.play()

func botLeft_low_health():
	if botLeftHealth == 0:
		$bottomLeftCore/green_light.visible = false
		$bottomLeftCore/red_light.visible = true
		botLeft_working = false
		is_monster_dead()
func topLeft_low_health():
	if topLeftHealth == 0:
		$topLeftCore/green_light.visible = false
		$topLeftCore/red_light.visible = true
		topLeft_working = false
		is_monster_dead()
func topRight_low_health():
	if topRightHealth == 0:
		$topRightCore/green_light.visible = false
		$topRightCore/red_light.visible = true
		topRight_working = false
		is_monster_dead()
func botRight_low_health():
	if botRightHealth == 0:
		$bottomRightCore/green_light.visible = false
		$bottomRightCore/red_light.visible = true
		botRight_working = false
		is_monster_dead()

func is_monster_dead():
	if !botLeft_working and !botRight_working and !topLeft_working and !topRight_working: 
		$Explosion.play("explosion")
		$DeathSound.play()
		world.monsterDead = true 

func _on_Explosion_animation_finished():
	queue_free()

func _on_NukeTimer_timeout():
	launch_nuke()
