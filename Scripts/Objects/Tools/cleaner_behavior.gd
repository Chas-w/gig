extends Node3D

@export var cleaner_held : bool
@export var cleaning : bool 
@export var cleaning_strength := 3
@export var targets : Array[Decal]

func _process(delta):
	#TODO inventory talking to 
	if(visible && !cleaner_held):
		visible = false
	if(cleaner_held && !visible):
		visible = true
		
	if(cleaner_held):
		if(Input.is_action_just_pressed("shoot") && !cleaning):
			cleaning = true
			_refresh_targets()
		if(Input.is_action_just_released("shoot")):
			cleaning = false
			
		if(cleaning && targets.size() > 0):
			for i in targets.size():
				if(targets[i] != null):
					targets[i]._clean_me(cleaning_strength)
					cleaning = false
	else:
		cleaning = false


func _add_to_targets(target):
	if(targets.size() > 0):
		if (!targets.has(target)):
			targets.append(target)
	else:
		targets.append(target)

func _remove_from_targets(target):
	targets = targets.filter(func(element): return element!=target)
	
func _refresh_targets():
	targets = targets.filter(func(element): return element!=null)

func _on_cleaner_zone_entered(area):
	if(area.is_in_group("Dirty")):
		_add_to_targets(area.get_parent())
func _on_cleaner_zone_exited(area):
	if(area.is_in_group("Dirty")):
		_remove_from_targets(area.get_parent())
