extends KinematicBody2D

var bulletSpeed = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	bulletSpeed.y = -1000

func _physics_process(delta):
	if position.y < -10:
		queue_free()
	move_and_slide(bulletSpeed)
