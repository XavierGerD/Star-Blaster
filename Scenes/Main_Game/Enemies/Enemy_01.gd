extends KinematicBody2D

var health = 2
var isDead = false

signal stopPath

func _on_Area2D_body_entered(body):
	if isDead: return
	if body.get_name() == "BulletType01":
		body.queue_free()
	if body.get_name() == "PlayerShipRed":
		body.playerHit(1)
	$EnemyHitAudio.play()
	health -= 1
	#$Enemy01Sprite.play("hit")
	if health <= 0:
		$Enemy01Sprite.play("explode")
		isDead = true
		emit_signal("stopPath")


func _on_Enemy01Sprite_animation_finished():
	queue_free()
