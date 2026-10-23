extends Control
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var health_bar: HealthBar = $Vitals/VBoxContainer2/HealthBar
@onready var gun_component: GunComponent = player.gun_component

@onready var ammo_counter: Label = $Vitals/VBoxContainer/AmmoCounter

func on_ammo_changed () -> void:
	ammo_counter.text = "Ammo: " + str(gun_component.ammo) + "/" + str(gun_component.max_ammo)

func _ready() -> void:
	
	health_bar.body = player
	on_ammo_changed()
	gun_component.ammo_changed.connect(on_ammo_changed)
