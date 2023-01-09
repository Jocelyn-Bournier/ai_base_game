extends TileMap

signal door_entered
signal door_exited
signal go_down
signal item_picked
signal victory

func place(pos):
	position=pos
	show()

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func _on_Door_door_entered(door):
	emit_signal("door_entered",door)

func _on_Door_door_exited(door):
	emit_signal("door_exited",door)
	
func go_down(hero):
	emit_signal("go_down",hero)


func _on_Key_area_entered(area):
	$Key.queue_free()
	emit_signal("item_picked","key")

func _on_Victory_area_entered(area):
	emit_signal("victory")
