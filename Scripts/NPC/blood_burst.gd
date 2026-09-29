extends Node3D
@export var blood : GPUParticles3D
@export var downcast : RayCast3D
@export var frontcast : RayCast3D
var life 
var down_collision
var front_collision

func _ready():
	blood.emitting = true
	life = blood.lifetime

func _process(delta):
	life -= delta
	down_collision = downcast.get_collision_point()
	front_collision = frontcast.get_collision_point()
	if(life <= 0):
		queue_free()
