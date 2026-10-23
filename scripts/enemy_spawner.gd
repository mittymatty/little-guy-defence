class_name EnemySpawner extends Marker2D

@export var enemies_left_to_spawn: Array[PackedScene]
@export var spawn_interval: float = 5.0
@export var first_spawn_on_ready: bool = false

@onready var delay_timer: Timer = $Delay

signal enemy_created (created_enemy: Enemy)

func spawn_enemy() -> void:
	for i in Settings.enemy_multiplier:
		if enemies_left_to_spawn.size() == 0:
			queue_free()
			return
		var next_enemy: PackedScene = enemies_left_to_spawn.front()
		var new_enemy: Enemy = next_enemy.instantiate()
		new_enemy.global_position = global_position
		#new_enemy.name = new_enemy.name + str(get_tree().get_nodes_in_group("enemies").size())
		get_tree().root.add_child.call_deferred(new_enemy,true)
		enemy_created.emit(new_enemy)
		await get_tree().create_timer(0.25).timeout
	
	enemies_left_to_spawn.pop_front()

func _ready() -> void:
	delay_timer.wait_time = spawn_interval
	if first_spawn_on_ready:
		spawn_enemy()

func _on_delay_timeout() -> void:
	spawn_enemy()
