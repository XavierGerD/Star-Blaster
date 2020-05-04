extends Node2D

onready var level = get_node("Level_01")

func _on_PlayerShipRed_entranceAnimHasPlayed():
	level.gameStarted = true
	level.playMusic()
