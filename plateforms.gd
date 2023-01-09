extends Node2D

onready var plateforms = self.get_children()
var collisioner = null
var collisionned = null

func _on_go_down(hero):
	for plateform in plateforms :
		if(plateform.collisioned == 0):
			collisioner = hero.get_node("CollisionShape2D")
			collisionned = plateform.name
			collisioner.set_deferred("disabled",true)
			break

func _on_plateform_body_exited(name):
	if(collisioner != null && name == collisionned):
		collisioner.set_deferred("disabled",false)
