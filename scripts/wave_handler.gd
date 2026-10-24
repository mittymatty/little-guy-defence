extends Node2D

@export var waves: Array[PackedScene] # Will stay the same
@onready var remaining_waves: Array[PackedScene] = waves.duplicate() # Will change

var current_wave: Node2D

func _physics_process (_delta: float) -> void:
	if !current_wave: return
	var remaining_spawners: int = 0
	for i in current_wave.get_children():
		if i is EnemySpawner:
			remaining_spawners += 1
	
	if remaining_spawners == 0 and PlayerStatus.active_enemies == 0:
		end_wave()

func end_wave () -> void:
	print("deleting wave")
	current_wave.queue_free()
	SignalBus.emit_wave_ended()
	
	if remaining_waves.size() == 0:
		print("game won")
		SignalBus.emit_game_won()

func on_setup_wave () -> void:
	var new_wave: Node2D = remaining_waves.pop_front().instantiate()
	add_child(new_wave)
	current_wave = new_wave
	PlayerStatus.current_wave = waves.find(current_wave)
	print(PlayerStatus.current_wave)
	SignalBus.emit_setup_wave()

func _ready() -> void:
	SignalBus.setup_wave.connect(on_setup_wave)
