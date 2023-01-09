extends RigidBody2D

onready var collision = $CollisionShape2D

var collisioned = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _on_Area2D_area_entered(body):
	collisioned = 0

func _on_Area2D_area_exited(body):
	collisioned = 1
	emit_signal("body_exited",self.name)
