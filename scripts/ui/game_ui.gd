extends Control
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var health_bar: HealthBar = $Vitals/Left/HealthBar
@onready var gun_component: GunComponent = player.gun_component
@onready var blocks_count: Label = $Vitals/Middle/BlocksCount
@onready var ammo_counter: Label = $Vitals/Right/AmmoCounter
@onready var troop_select: MarginContainer = $TroopSelect
@onready var continue_button: Button = $TroopSelect/VBoxContainer/ContinueButton

func on_ammo_changed () -> void:
	ammo_counter.text = "Ammo: " + str(gun_component.ammo) + "/" + str(gun_component.max_ammo)

func on_blocks_changed () -> void:
	blocks_count.text = str(PlayerStatus.blocks)

func open_troop_selector () -> void:
	troop_select.show()
	PlayerStatus.current_click_mode = PlayerStatus.CLICK_MODE.NONE

func close_troop_selector () -> void:
	troop_select.hide()
	PlayerStatus.current_click_mode = PlayerStatus.CLICK_MODE.PLACE

func _ready() -> void:
	health_bar.body = player
	on_ammo_changed()
	on_blocks_changed()
	open_troop_selector()
	continue_button.pressed.connect(close_troop_selector)
	SignalBus.blocks_changed.connect(on_blocks_changed)
	gun_component.ammo_changed.connect(on_ammo_changed)
