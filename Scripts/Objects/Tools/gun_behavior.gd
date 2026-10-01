extends Node3D

@export var gun_held : bool
##far. mid, close damage
@export var shot_damage : Vector3
##far, close range
@export var shot_range : Vector2
@export var spray : Array[RayCast3D]

func _process(delta):
	#TODO inventory talking to 
	if(visible && !gun_held):
		visible = false
	if(gun_held && !visible):
		visible = true

func _input(event: InputEvent) -> void:
	if (event.is_action_pressed("shoot") && gun_held):
		_shot_fired()

func _shot_fired():
	for s in spray.size():
		if(spray[s].is_colliding() && spray[s].get_collider() != null):
			if(spray[s].get_collider().is_in_group("NPC")):
				_process_damage(s,spray[s].get_collider())



func _process_damage(i, target):
	var distance_away = global_transform.origin.distance_to(target.global_transform.origin)
	target.gun = self
	if(distance_away >= shot_range.x):
		target._injure_me(shot_damage.x)
		#print("far shot")
	if(distance_away < shot_range.x && distance_away >= shot_range.y):
		target._injure_me(shot_damage.y)
		#print("mid shot")
	if(distance_away < shot_range.y):
		target._injure_me(shot_damage.z)
		#print("close shot")
