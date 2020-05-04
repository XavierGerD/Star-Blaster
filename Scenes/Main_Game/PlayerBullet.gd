extends KinematicBody2D

var bulletSpeed = Vector2()

func _ready():
	bulletSpeed.y = -1000

func _physics_process(delta):
	if position.y < -10:
		queue_free()
	move_and_slide(bulletSpeed)
