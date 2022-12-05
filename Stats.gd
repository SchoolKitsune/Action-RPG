extends Node

export(int) var max_health = 1 #(int) doesn't allow decimals
onready var health = max_health setget set_health #set tells godot that we wanna use this function anytime the health var changes

signal no_health

func set_health(value):
	health = value #now each time the health changes we will check if it changes
	if health <= 0:
		emit_signal("no_health")
