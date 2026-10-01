extends Decal
var full_scale : Vector3
@export var done_spread : bool
var grow_speed := .1

var spread_margin_of_error := .1
var dirty_amt := 1
var dirty_margin_of_error := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dirty_amt = scale.x
	full_scale = scale
	if(!done_spread):
		scale = Vector3.ZERO

func _clean_me(cleaner_strength):
	dirty_amt = scale.x * 10
	dirty_amt -= cleaner_strength
	scale = scale/1.2
	if(!done_spread):
		done_spread = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!done_spread):
		scale = scale.lerp(full_scale,grow_speed * delta)
		if(full_scale.x - scale.x <= spread_margin_of_error):
			done_spread = true
			print(name + " DONE SPREADING")
	
	#TODO add more checks and systems for if this is cleaned or not 
	#NOTE not all tools can completely clean all MESS
	if(dirty_amt <= dirty_margin_of_error):
		print("CLEANED " + name)
		queue_free()
