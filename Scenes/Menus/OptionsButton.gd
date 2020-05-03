extends Button

onready var menuItemTweenTotalTime = get_parent().menuItemTweenTotalTime
onready var menuItemTweenDelay = get_parent().menuItemTweenDelay

func animateIntro():
	self.rect_position.x = 540
	var endPosition = Vector2(64, 688)
	$OptionsButtonTween.interpolate_property(
		self,
		"rect_position",
		self.rect_position,
		endPosition,
		menuItemTweenTotalTime,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		menuItemTweenDelay)
	$OptionsButtonTween.start()

func _ready():
	animateIntro()


func _on_NewGameButton_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")	
	
