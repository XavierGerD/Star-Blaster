extends Node2D

var time = 0
var gameStarted = false

onready var music = get_node("LevelMusic")

#type1 paths
onready var path01 = get_node("Path01_01/Path2D")
onready var path02 = get_node("Path01_02/Path2D")
onready var path03 = get_node("Path01_03/Path2D")
onready var path04 = get_node("Path01_04/Path2D")

#type2 paths
onready var path05 = get_node("Path02_01/Path2D")
onready var path06 = get_node("Path02_02/Path2D")
onready var path07 = get_node("Path02_03/Path2D")
onready var path08 = get_node("Path02_04/Path2D")

func playMusic():
	music.play()

func _process(delta):
	if !gameStarted: return
	time += delta
	if time > 1 && self.has_node("Path01_01/Path2D"):
		path01.animate(delta)
	if time > 1.5 && self.has_node("Path01_02/Path2D"):
		path02.animate(delta)
	if time > 2 && self.has_node("Path01_03/Path2D"):
		path03.animate(delta)
	if time > 2.5 && self.has_node("Path01_04/Path2D"):
		path04.animate(delta)
	if time > 3.5 && self.has_node("Path02_01/Path2D"):
		path05.animate(delta)
	if time > 4 && self.has_node("Path02_02/Path2D"):
		path06.animate(delta)
	if time > 4.5 && self.has_node("Path02_03/Path2D"):
		path07.animate(delta)
	if time > 5 && self.has_node("Path02_04/Path2D"):
		path08.animate(delta)

