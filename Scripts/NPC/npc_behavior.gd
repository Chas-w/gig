extends RigidBody3D

@export_category("Health Stuff")
@export_range(0,100,1) var max_health := 10
var health
var blood_emitter = load("res://Scenes/NPC/blood_emitter.tscn")
var emit_blood : bool
var linger_timer := .1

@export_category("On Shoot Stuff")
@export var limbs_organs_path : Array[String]
@export var limbs_organs : Array
var limbs_spawned : Array[bool]

#:= [load("res://Imports/TEMP/Scenes/test_limb_organ.tscn")]

@export_category("Movement Stuff")
@export var aggressive : bool 
var gun : Node3D
var dying : bool 

func _ready():
	health = max_health
	for i in limbs_organs_path.size():
		limbs_spawned.append(false)

func _process(delta: float) -> void:
	if(health <= 0 && !dying):
		_kill_me()
	_assign_organ_path()

func _injure_me(damage : float):
	health -= damage
	if(health > 0):
		gun = null
	print(str(name) + " recieved " + str(damage) + " damage, remaining health: " + str(health))
	#TODO reaction

func _kill_me():
	for i in limbs_organs.size(): 
		if(!limbs_spawned[i]):
			var instance = limbs_organs[i].instantiate()
			get_tree().get_root().add_child(instance)
			instance.global_position = global_position  
			limbs_spawned[i] = true
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
			dying = true
			print(name + " was killed")
			queue_free()

func _assign_organ_path():
	if(limbs_organs.size() != limbs_organs_path.size()):
		for i in limbs_organs_path.size(): 
			limbs_organs.append(load(limbs_organs_path[i]))
