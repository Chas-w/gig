extends RigidBody3D

@export_category("Health Stuff")
@export_range(0,100,1) var max_health := 10
var health
var blood_emitter = load("res://Scenes/NPC/blood_emitter.tscn")
var emit_blood : bool
var linger_timer := .1
@export var in_gun_range : bool
@export var limbs_organs_path : Array[String]
@export var limbs_organs : Array
var limbs_spawned : Array[bool]

#:= [load("res://Imports/TEMP/Scenes/test_limb_organ.tscn")]

@export_category("Movement Stuff")
@export var aggressive : bool 
var gun : Node3D

func _ready():
	health = max_health
	for i in limbs_organs_path.size():
		limbs_spawned.append(false)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health <= 0):
		_kill_me()
	_assign_organ_path()

func _injure_me(damage : float):
	health -= damage
	print(str(name) + " recieved " + str(damage) + " damage, remaining health: " + str(health))
	#TODO reaction

func _kill_me():
	print(name + " is dead")
	for i in limbs_organs.size(): 
		if(!limbs_spawned[i]):
			var instance = limbs_organs[i].instantiate()
			get_tree().get_root().add_child(instance)
			instance.global_position = global_position  
			limbs_spawned[i] = true
	#TODO blood
	if(!emit_blood):
		var blood_burst = blood_emitter.instantiate()
		get_tree().get_root().add_child(blood_burst)
		blood_burst.global_transform.basis.z = -gun.global_transform.basis.z
		blood_burst.global_position = global_position 
		print(name + " Emit Blood")
		emit_blood = true
	else:
		if(linger_timer > 0):
			linger_timer -= get_process_delta_time()
		else:
			queue_free()
	
func _assign_organ_path():
	if(limbs_organs.size() != limbs_organs_path.size()):
		for i in limbs_organs_path.size(): 
			limbs_organs.append(load(limbs_organs_path[i]))

func _remove_from_range():
	if(gun.npcs_in_range.size() - 1 <= 1):
		gun.npcs_in_range.remove_at(0)
	else:
		for i in gun.npcs_in_range.size() -1:
			if (gun.npcs_in_range[i] != null && gun.npcs_in_range[i].name == name):
				gun.npcs_in_range.remove_at(i)
				gun = null
func _handle_removing_gun_range():
	in_gun_range = false
	_remove_from_range()

func _on_hurt_box_area_entered(area: Area3D) -> void:
	if(area.is_in_group("Gun")):
		in_gun_range = true
		gun = area.get_parent()
		gun.npcs_in_range.append(self)
func _on_hurt_box_area_exited(area: Area3D) -> void:
	if(area.is_in_group("Gun")):
		_handle_removing_gun_range()
