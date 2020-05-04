extends KinematicBody2D

#Ship management variables
var shipPositionAtStart = Vector2(288, 1100)
var shipPositionAfterAnim = Vector2(288, 930)
var shipX = 288
var shipY = 930
var shipSpeed = 700
var shipShootingSpeed = 0.3
var playerHealth = 2

var isClicking
var isDragging = false
var isShooting = false
var isDead = false
var gameStarted = false

signal entranceAnimHasPlayed

onready var PlayerMovementTween = get_node("PlayerShipRed/PlayerMovementTween")
onready var entranceAnimationTween = get_node("PlayerShipRed/EntranceAnimationTween")
onready var playerShootTimer = get_node("PlayerShipRed/PlayerShootTimer")
onready var playerBullet = load("res://Scenes/Main_Game/PlayerBullet.tscn")

func _ready():
	get_viewport().audio_listener_enable_2d = true
	position = shipPositionAtStart
	entranceAnimationWithTween()

func generateBullet():
	var bullet = playerBullet.instance()
	bullet.position.x = position.x
	bullet.position.y = position.y - 10
	get_parent().add_child(bullet)

func playerShoot():
	if isShooting || isDead || !gameStarted: return
	playerShootTimer.wait_time = shipShootingSpeed
	playerShootTimer.start()
	isShooting = true
	generateBullet()
	$"PlayerShipRed/ShipShoot".play()

func playerHit(damage):
	if isDead: return
	playerHealth -= damage
	if playerHealth <= 0:
		playerDead()
		
	
func playerDead():
	print("player dead!")
	isDead = true
	$"PlayerShipRed/ShipExplode".play()
	$PlayerShipRed.play("explode")
	$PlayerShipRed/Engine.queue_free()

func _on_PlayerShootTimer_timeout():
	isShooting = false

func findDeltasAndSquare(pos1, pos2):
	var side = pos1 - pos2
	if side > 0:
		$PlayerShipRed.play('tilt-right')
	if side < 0:
		$PlayerShipRed.play('tilt-left')
	return pow(side, 2)

func findCurrentSpeed(mousePosition, position):
	var sideX = findDeltasAndSquare(mousePosition.x, position.x)
	var sideY = findDeltasAndSquare(mousePosition.y, position.y)
	var hypotenuse = sqrt(sideX + sideY)
	return hypotenuse / shipSpeed

func moveShipWithTween():
	var mousePosition = get_global_mouse_position()
	var currentSpeed = findCurrentSpeed(mousePosition, position)
	PlayerMovementTween.interpolate_property(
		self,
		"position",
		position,
		mousePosition,
		currentSpeed,
		PlayerMovementTween.TRANS_LINEAR,
		PlayerMovementTween.EASE_IN_OUT)
	PlayerMovementTween.start()

func entranceAnimationWithTween():
	entranceAnimationTween.interpolate_property(
		self,
		"position",
		position,
		shipPositionAfterAnim,
		2,
		entranceAnimationTween.TRANS_LINEAR,
		entranceAnimationTween.EASE_IN_OUT)
	entranceAnimationTween.start()

func _input(event):
	if isDead || !gameStarted: return
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			isDragging = true
			
		if !event.pressed:
			isDragging = false
		moveShipWithTween()
		
	if event is InputEventMouseMotion and isDragging:
		moveShipWithTween()	
	
func _on_PlayerMovementTween_tween_all_completed():
	$PlayerShipRed.play("idle")

func _on_EntranceAnimationTween_tween_all_completed():
	gameStarted = true
	emit_signal("entranceAnimHasPlayed")

func _process(_delta):
	playerShoot()


