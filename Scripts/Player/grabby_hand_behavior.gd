extends Node3D

@export var hand_empty : bool
@onready var pickup_cast = %"Pickup Cast"

var attempt_grab : bool 
var grab_target 
var grab_speed := 20
var throw_force := 5

func _process(delta):
	if(attempt_grab):
		_grab_obj(grab_target)
	
	if(pickup_cast.is_colliding() && hand_empty):
		for i in pickup_cast.get_collision_count():
			if(pickup_cast.get_collider(i).is_in_group("Pickup")):
				##TODO highlight material 
				if(Input.is_action_just_pressed("shoot")):
					grab_target = pickup_cast.get_collider(i)
					attempt_grab = true #trigger grab object logic
	if(!hand_empty && grab_target != null):
	##TODO hold increases throw force
		if(Input.is_action_just_pressed("shoot")):
			_drop_obj()

func _grab_obj(grab_obj):
	hand_empty = false
	grab_obj.linear_velocity = Vector3.ZERO
	grab_obj.global_position = lerp(grab_obj.global_position,global_position,grab_speed * get_process_delta_time())

	
func _drop_obj():
	attempt_grab = false
	grab_target.apply_impulse(-global_transform.basis.z * throw_force)
	grab_target.apply_impulse(global_transform.basis.y * throw_force)

	grab_target = null
	hand_empty = true
	
