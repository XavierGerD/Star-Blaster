extends Button

onready var menuItemTweenTotalTime = get_parent().menuItemTweenTotalTime
onready var menuItemTweenDelay = get_parent().menuItemTweenDelay

func animateIntro():
	self.rect_position.x = -450
	var endPosition = Vector2(64, 800)
	$NewGameTween.interpolate_property(
		self,
		"rect_position",
		self.rect_position,
		endPosition,
		menuItemTweenTotalTime,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		menuItemTweenDelay)
	$NewGameTween.start()

func _ready():
	animateIntro()

