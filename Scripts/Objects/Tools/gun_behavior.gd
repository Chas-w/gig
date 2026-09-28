extends Node3D

@export var gun_held : bool
@export var npcs_in_range : Array[RigidBody3D]
##far. mid, close damage
@export var shot_damage : Vector3
##far, close range
@export var shot_range : Vector2

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("shoot")):
		_shot_fired()

func _shot_fired():
	if(npcs_in_range.size() > 0):
		for i in npcs_in_range.size():
			if(npcs_in_range[i] != null):
				_process_damage(i)
			_refresh_range(i)

func _process_damage(i):
	var distance_away = global_transform.origin.distance_to(npcs_in_range[i].global_transform.origin)
	if(distance_away >= shot_range.x):
		npcs_in_range[i]._injure_me(shot_damage.x)
		print("far shot")
	if(distance_away < shot_range.x && distance_away >= shot_range.y):
		npcs_in_range[i]._injure_me(shot_damage.y)
		print("mid shot")
	if(distance_away < shot_range.y):
		npcs_in_range[i]._injure_me(shot_damage.z)
		print("close shot")

func _refresh_range(i):
	if(npcs_in_range[i] == null):
		npcs_in_range.remove_at(i)
