extends Node2D

var menuItemTweenTotalTime = 1
var menuItemTweenDelay = 2.8
onready var mainGame = load("res://Scenes/Main_Game/Main.tscn")
onready var swipeAnim = get_node("Transition1/SwipeAnim")
onready var swipeTween = get_node("Transition1/SwipeAnim/SwipeAnimTween")
onready var mask = get_node("Mask")


func animComplete():
	self.visible = false

func moveMask(object, key, elapsed, value):
	mask.position.y = value.y - 1400

func _ready():
	swipeTween.connect("tween_all_completed", self, "animComplete")
	swipeTween.connect("tween_step", self, "moveMask")
	$MainMenuMusic.play()

func _on_NewGameButton_pressed():
	swipeAnim.animate()
	var game = mainGame.instance()
	get_parent().add_child(game)
	fadeOutMusic()
	
	
func _on_OptionsButton_pressed():
	pass # Replace with function 
	
func fadeOutMusic():
	print("fading out")
	$MainMenuMusic/MusicFadeoutTween.interpolate_property(
		$MainMenuMusic,
		"volume_db",
		0,
		-80,
		2,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT)
	$MainMenuMusic/MusicFadeoutTween.start()
