extends Node

var itemList = {}
#Item : name,quantity

func _ready():
	pass # Replace with function body.

func add(item) :
	if(itemList.has(item)):
		itemList[item] += 1
	else : itemList[item] = 1

func remove(item) :
	pass

func getAll() :
	return itemList
	
func has(item) :
	return itemList.has(item)
