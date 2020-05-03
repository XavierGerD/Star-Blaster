extends KinematicBody2D

#Ship management variables
var shipX = 288
var shipY = 930
var shipSpeed = 700
var shipShootingSpeed = 1

var isClicking
var isDragging = false
var isShooting = false

onready var Tween = get_node("PlayerShipRed/PlayerShipTween")
onready var playerShootTimer = get_node("PlayerShipRed/PlayerShootTimer")
onready var playerBullet = load("res://Scenes/Main_Game/PlayerBullet.tscn")

func _ready():
	get_viewport().audio_listener_enable_2d = true
	position = Vector2(shipX, shipY)

func generateBullet():
	var bullet = playerBullet.instance()
	bullet.position.x = position.x
	bullet.position.y = position.y
	get_parent().add_child(bullet)

func playerShoot():
	if isShooting: return
	playerShootTimer.wait_time = shipShootingSpeed
	playerShootTimer.start()
	isShooting = true
	generateBullet()
	$"PlayerShipRed/Ship shoot".play()
	
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
	Tween.interpolate_property(
		self,
		"position",
		position,
		mousePosition,
		currentSpeed,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT)
	Tween.start()


func _process(delta):
	playerShoot()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			isDragging = true
			
		if !event.pressed:
			isDragging = false
		moveShipWithTween()
		
	if event is InputEventMouseMotion and isDragging:
		moveShipWithTween()


func _on_PlayerShipTween_tween_all_completed():
	$PlayerShipRed.play("idle")
