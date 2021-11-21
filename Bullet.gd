extends Area2D


export (Vector2) var velocity = Vector2()

func _ready():
	pass

func _physics_process(delta):
	position += velocity


func _on_lifeTimer_timeout():
	$lifeTimer.queue_free()
