extends AnimatedSprite

func _ready():
	connect("animation_finished", self, "_on_animation_finished")
	frame = 0 #line 5 is not really necessary
	play("Animate")


func _on_animation_finished(): #once the animation for "Animate" ends remove the leaves
	queue_free()
