extends RigidBody2D

onready var monster = $"/root/Game/World/TrashMonster"
onready var player = $"/root/Game/World/Player"
onready var ground = $"/root/Game/World/TileMap"

onready var sprite = $AnimatedSprite
onready var blast_area = $BlastArea/CollisionShape2D
var area_of_effect = Vector2(6,6)
var blasted = false


	

func blast_off():
	blast_area.scale = area_of_effect
	blast_area.call_deferred("set","disabled",false)
	sprite.scale = area_of_effect
	sprite.play("explosion")
	$BlastSound.play()

func _on_Nuke_body_entered(body):
	if !blasted and (body==ground or body==player):
		blasted = true
		$TimerSound.play()		

func _on_BlastArea_body_entered(body):
	if body==player: player.die()
	elif body==ground or body==monster or body.is_in_group("nukes") or body.get_node("../")==monster: pass
	else: body.queue_free()

func _on_AnimatedSprite_animation_finished():
	queue_free()

func _on_TimerSound_finished():
	blast_off()
