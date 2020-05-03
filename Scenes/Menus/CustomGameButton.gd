extends Button

onready var menuItemTweenTotalTime = get_parent().menuItemTweenTotalTime
onready var menuItemTweenDelay = get_parent().menuItemTweenDelay

func animateIntro():
	self.rect_position.x = -450
	var endPosition = Vector2(64, 576)
	$CustomGameTween.interpolate_property(
		self,
		"rect_position",
		self.rect_position,
		endPosition,
		menuItemTweenTotalTime,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		menuItemTweenDelay)
	$CustomGameTween.start()

func _ready():
	animateIntro()


func _on_NewGameButton_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")	
	
