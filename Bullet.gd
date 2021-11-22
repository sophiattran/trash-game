extends RigidBody2D

#onready var core = $'../TrashMonster/Core'
onready var monster = $'../TrashMonster'
onready var botLeft = $'../TrashMonster/bottomLeftCore'
onready var topLeft = $'../TrashMonster/topLeftCore'
onready var topRight = $'../TrashMonster/topRightCore'
onready var botRight = $'../TrashMonster/bottomRightCore'

func _on_LifeTimer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	#play blasting animation
	sleeping = true
	set_collision_mask(0)
	$AnimatedSprite.play("explosion")
	$LifeTimer.start()
	$BlastSound.play()
	
	if body.is_in_group("trash"): 
		body.set_collision_layer(0)
		body.queue_free()
	elif body == botLeft:
		monster.botLeftHealth -= 10
		print("hit bottom left, health:", monster.botLeftHealth)
		monster.botLeft_low_health()
	elif body == topLeft:
		monster.topLeftHealth -= 10
		print("hit top left, health:", monster.topLeftHealth)
		monster.topLeft_low_health()
	elif body == topRight:
		monster.topRightHealth -= 10
		print("hit top right, health:", monster.topRightHealth)
		monster.topRight_low_health()
	elif body == botRight:
		monster.botRightHealth -= 10
		print("hit bottom right, health:", monster.botRightHealth)
		monster.botRight_low_health()
		
