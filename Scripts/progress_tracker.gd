extends Node

@export_category("Cleaning")
@export var all_dirty_decals : Array[Decal]
var dirty_percentage : float

func _ready():
	for game_obj in get_tree().get_nodes_in_group("Dirty"): #assign database
		if(game_obj is Decal):
			all_dirty_decals.append(game_obj)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_update_decal_tracker()
	

##used to track how many blood or dirt splatters are in the scene
#NOTE might be a more efficient way to dot his... look into it chase
func _update_decal_tracker():
	for game_obj in get_tree().get_nodes_in_group("Dirty"): #assign database
		if(game_obj is Decal && !all_dirty_decals.has(game_obj)):
			all_dirty_decals.append(game_obj)
	all_dirty_decals = all_dirty_decals.filter(func(element): return element!=null)
