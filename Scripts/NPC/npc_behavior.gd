extends RigidBody3D

@export_range(0,100,1) var max_health := 10
var health
@export var in_gun_range : bool
var gun : Node3D

func _ready():
	health = max_health

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(health <= 0):
		_kill_me()

func _injure_me(damage : float):
	health -= damage
	print(str(name) + " recieved " + str(damage) + " damage, remaining health: " + str(health))
	#TODO reaction

func _kill_me():
	print(name + " is dead")
	#TODO blood
	queue_free()
	
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
