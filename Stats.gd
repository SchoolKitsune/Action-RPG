extends Node

export(int) var max_health = 1 setget set_max_health#(int) doesn't allow decimals
var health = max_health setget set_health #set tells godot that we wanna use this function anytime the health var changes

signal no_health
signal health_changed(value)
signal max_health_changed(value)

func set_max_health(value):
	max_health = value
	self.health = min(health, max_health)# makes sure our health is never higher than our max health
	emit_signal("max_health_changed", max_health)

func set_health(value):
	health = value #now each time the health changes we will check if it changes
	emit_signal("health_changed", health)
	if health <= 0:
		emit_signal("no_health") #so whenever our health changes we emit a signal that our health should change

func _ready():
	self.health = max_health
