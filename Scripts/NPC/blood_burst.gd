extends Node3D
@export var blood : GPUParticles3D

var life = 2


func _ready():
	blood.emitting = true

func _process(delta):
	life -= delta
	if(life <= 0 ):
		print("Removing Blood Spray")
		queue_free()
