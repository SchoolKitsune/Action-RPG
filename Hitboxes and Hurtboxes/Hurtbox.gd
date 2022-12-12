extends Area2D

const HitEffect = preload("res://Effects/HitEffect.tscn")

var invincible = false setget set_invincible

onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")

func start_invincibility(duration): #this func starts invincibility
	self.invincible = true
	timer.start(duration) # which start our timer

func create_hit_effect(area):
	var effect = HitEffect.instance()
	var main = get_tree().current_scene
	main.add_child(effect)
	effect.global_position = global_position

func _on_Timer_timeout():
	self.invincible = false #we call self since the setter will only get activated when we call self
# once the timer is done we set invincibility to false


func _on_Hurtbox_invincibility_started():
	set_deferred("monitoring", false)
	#monitoring = false

func _on_Hurtbox_invincibility_ended():
	set_deferred("monitoring", true)
	#monitoring = true
