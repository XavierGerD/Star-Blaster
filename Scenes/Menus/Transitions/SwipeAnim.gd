extends Sprite

func animate():
	var endPosition = Vector2()
	endPosition.y = 1024 + self.texture.get_size().y
	$SwipeAnimTween.interpolate_property(
		self,
		"position",
		position,
		endPosition,
		0.7,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT)
	$SwipeAnimTween.start()
	

func _on_SwipeAnimTween_tween_all_completed():
	queue_free()
