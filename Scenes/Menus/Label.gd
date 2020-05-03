extends Label

func animateIntro():
	self.rect_position.y = -400
	var endPosition = Vector2(1, 64)
	$LogoTween.interpolate_property(
		self,
		"rect_position",
		self.rect_position,
		endPosition,
		3.8,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT
		)
	$LogoTween.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	animateIntro()
