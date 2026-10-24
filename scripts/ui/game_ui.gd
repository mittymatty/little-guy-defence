extends Control
@onready var player: Player = get_tree().get_first_node_in_group("player")
@onready var gun_component: GunComponent = player.gun_component

@onready var health_bar: HealthBar = $Vitals/Left/HealthBar
@onready var wave_count: Label = $Vitals/Middle/WaveCount
@onready var blocks_count: Label = $Vitals/Middle/BlocksCount
@onready var ammo_counter: Label = $Vitals/Right/AmmoCounter

@onready var troop_select: MarginContainer = $TroopSelect
@onready var troop_button_container: HBoxContainer = $TroopSelect/VBoxContainer/MarginContainer/TroopButtonContainer

@onready var refresh: Button = $TroopSelect/VBoxContainer/HBoxContainer/Refresh
@onready var refresh_price: Label = $TroopSelect/VBoxContainer/HBoxContainer/Refresh/HBoxContainer/Price

@onready var continue_button: Button = $TroopSelect/VBoxContainer/HBoxContainer/ContinueButton

const TROOP_BUTTON = preload("uid://bdmyssrhu4j55")
var trooper_buttons_at_a_time: int = 3

func create_troop_buttons () -> void:
	var possible_troops: Array[TroopData] = PlayerStatus.all_possible_troop_data.duplicate()
	for old: TroopButton in troop_button_container.get_children():
		old.queue_free()
	
	for i: int in trooper_buttons_at_a_time:
		var new_tb: TroopButton = TROOP_BUTTON.instantiate()
		new_tb.troop_data = possible_troops.pop_at(randi_range(0,possible_troops.size() - 1))
		troop_button_container.add_child(new_tb,true)

func on_ammo_changed () -> void:
	ammo_counter.text = "Ammo: " + str(gun_component.ammo) + "/" + str(gun_component.max_ammo)

func on_blocks_changed () -> void:
	blocks_count.text = ": " + str(PlayerStatus.blocks)

func open_troop_selector () -> void:
	PlayerStatus.current_click_mode = PlayerStatus.CLICK_MODE.NONE
	PlayerStatus.current_refresh_cost = PlayerStatus.base_refresh_cost
	update_refresh_label()
	create_troop_buttons()
	troop_select.show()

func close_troop_selector () -> void:
	PlayerStatus.current_click_mode = PlayerStatus.CLICK_MODE.PLACE
	troop_select.hide()

func on_wave_change () -> void:
	wave_count.text = "Wave: " + str(PlayerStatus.current_wave)

func on_refreshed () -> void:
	if PlayerStatus.blocks >= PlayerStatus.current_refresh_cost:
		PlayerStatus.blocks -= PlayerStatus.current_refresh_cost
		PlayerStatus.current_refresh_cost += 1
		SignalBus.emit_blocks_changed()
		update_refresh_label()
		create_troop_buttons()

func update_refresh_label () -> void:
	refresh_price.text = str(PlayerStatus.current_refresh_cost)

func _ready() -> void:
	health_bar.body = player
	on_ammo_changed()
	on_blocks_changed()
	open_troop_selector()
	
	refresh.pressed.connect(on_refreshed)
	continue_button.pressed.connect(close_troop_selector)
	SignalBus.blocks_changed.connect(on_blocks_changed)
	gun_component.ammo_changed.connect(on_ammo_changed)
	SignalBus.begin_wave.connect(on_wave_change)
