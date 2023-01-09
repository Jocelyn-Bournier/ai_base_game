extends Node

# Declare member variables here. Examples:
const GRAVITY = 15

var transitionDoor = 0
var currLevel = 0
var doorToTransition = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	
	#SENSIBLE, TO REMOVE FIRST IF THERE IS ANY PHYSIC ISSUE OR UNIDENTIFIED ISSUE
	Engine.time_scale = 4.0
	Engine.iterations_per_second = 240
	
	$Level_0.place($MapOrigin.position)
	$Hero.start(get_node("Level_"+String(currLevel)).position+get_node("Level_"+String(currLevel)+"/StartingPos").position,GRAVITY)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func changeLevel(from,to):
	$Hero.hide()
	print("from ",from," to ",to)
	get_node("Level_"+String(to)).place($MapOrigin.position)
	get_node("Level_"+String(from)).place($MapStorage.position)
	print(get_node("Level_"+String(to)+"/Doors/Door_to_level_"+String(from)))
	$Hero.start($MapOrigin.position+get_node("Level_"+String(to)+"/Doors/Door_to_level_"+String(from)).position,GRAVITY)
	currLevel = to

func _on_Level_door_entered(door):
	print("map accessible ",door)
	transitionDoor = 1
	doorToTransition = int(door)
	
func _on_Level_door_exited(door):
	print("map unaccessible ", door)
	transitionDoor = 0
	doorToTransition = -1

func _on_Hero_interact():
	if(transitionDoor == 1):
		print("open level ",doorToTransition)
		changeLevel(currLevel,doorToTransition)


func _on_Hero_go_down():
	var level = get_node("Level_"+String(currLevel))
	level.go_down($Hero)


func _on_item_picked(item):
	$Hero/Inventory.add(item)
	print($Hero/Inventory.getAll())
	
func _on_Level_victory():
	if($Hero/Inventory.has("key")):
		print("victory !")
