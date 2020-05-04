extends Path2D

onready var path = get_node("PathFollow2D")

var isPlaying = false

func animate(delta):
	if isPlaying: return
	path.set_offset(path.get_offset() + 350 * delta)
	
	if path.get_unit_offset() >= 1:
		queue_free()
	
#func _process(delta):
#	if !isPlaying: return

func _on_Enemy_stopPath():
	isPlaying = true
