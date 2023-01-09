extends Area2D

signal door_entered
signal door_exited

func _ready():
	pass

func _on_Door_body_entered(_body):
	emit_signal("door_entered",self.name[self.name.length()-1]) # Replace with function body.

func _on_Door_body_exited(_body):
	emit_signal("door_exited",self.name[self.name.length()-1]) # Replace with function body.
