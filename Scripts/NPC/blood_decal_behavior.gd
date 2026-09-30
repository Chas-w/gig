extends Decal
var full_scale : Vector3
var done_spread : bool
var grow_speed := .2
var margin_of_error := .1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	full_scale = scale
	scale = Vector3.ZERO


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!done_spread):
		scale = scale.lerp(full_scale,grow_speed * delta)
		if(full_scale.x - scale.x <= margin_of_error):
			done_spread = true
			print(name + " DONE SPREADING")
