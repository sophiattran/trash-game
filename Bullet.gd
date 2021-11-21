extends RigidBody2D

onready var core = $'../TrashMonster/Core'

func _on_LifeTimer_timeout():
	queue_free()

func _on_Bullet_body_entered(body):
	#play blasting animation
	sleeping = true
	set_collision_mask(0)
	$AnimatedSprite.play("explosion")
	$LifeTimer.start()
	
	if body.is_in_group("trash"): 
		body.set_collision_layer(0)
		body.queue_free()
		$BlastSound.play()
	elif body == core:
		print("core hit, decrease monster's health")

