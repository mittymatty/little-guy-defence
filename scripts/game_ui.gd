extends Control
@export var player: Player
@onready var health_bar: HealthBar = $MarginContainer/VBoxContainer/HealthBar

func _ready() -> void:
	health_bar.body = player
