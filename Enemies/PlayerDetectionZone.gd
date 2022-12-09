extends Area2D

var player = null

func can_see_player():
	return player != null #if player is = to null it is set to false, we can't see the player

func _on_PlayerDetectionZone_body_entered(body):
	player = body


func _on_PlayerDetectionZone_body_exited(body):
	player = null
