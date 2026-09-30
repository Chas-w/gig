extends Node3D
@export var blood : GPUParticles3D
var blood_splatter = preload("res://Scenes/NPC/blood_decal.tscn")
@export var downcasts : Array[RayCast3D]
var checked_this_downcast : Array[bool]
var life = 2
@export var ready_to_remove : bool

func _enter_tree() -> void:
	blood.restart(false)
	
func _ready():
	for i in downcasts.size(): 
		checked_this_downcast.append(false)


func _process(delta):
	if (ready_to_remove):
		if(life <= 0 ):
			print("Removing Blood Spray")
			queue_free()
		else:
			life -= delta

	for i in downcasts.size(): 
		if(downcasts[i].is_colliding() && !checked_this_downcast[i]):
			var splatter = blood_splatter.instantiate()
			get_tree().get_root().add_child(splatter)
			splatter.position = downcasts[i].get_collision_point()
			checked_this_downcast[i] = true
			print("SPLATTER PLACED")
		if (i >= downcasts.size() - 1):
			ready_to_remove = true
