extends Control

@onready var health_bar: ProgressBar = %HealthBar
@onready var player = $"../.."

var health : float
var max_health : float = 100
var hunger : float
var max_hunger : float = 100

var is_sprinting : bool
var main_player : bool

func update_health_bar(health_change):
	health_bar.value = health_bar.value + health_change

func setup(player, max_health, max_hunger):
	self.player = player
	self.max_health = max_health
	self.max_hunger = max_hunger
	set_bar_values()

func set_bar_values():
	health_bar.max_value = max_health
	health_bar.value = max_health
