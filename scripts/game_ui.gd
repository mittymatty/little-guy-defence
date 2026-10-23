extends Control
@export var player: Player
@onready var health_bar: HealthBar = $MarginContainer/VBoxContainer2/HealthBar
@onready var gun_component: GunComponent = player.gun_component

@onready var ammo_counter: Label = $MarginContainer/VBoxContainer/AmmoCounter

func on_ammo_changed () -> void:
	ammo_counter.text = "Ammo: " + str(gun_component.ammo) + "/" + str(gun_component.max_ammo)

func _ready() -> void:
	health_bar.body = player
	on_ammo_changed()
	gun_component.ammo_changed.connect(on_ammo_changed)
