extends RigidBody3D

@export var in_gun_range : bool
var gun : Node3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(in_gun_range):
		print(name + " in danger")

func _injure_me():
	pass

func _kill_me():
	pass

func _on_hurt_box_area_entered(area: Area3D) -> void:
	if(area.is_in_group("Gun")):
		in_gun_range = true
		gun = area.get_parent()
func _on_hurt_box_area_exited(area: Area3D) -> void:
	if(area.is_in_group("Gun")):
		in_gun_range = false
		gun = null
