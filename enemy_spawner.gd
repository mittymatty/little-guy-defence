class_name EnemySpawner extends Marker2D

@export var enemies_left_to_spawn: Array[PackedScene]

signal enemy_created (created_enemy: Enemy)

func _ready() -> void:
	pass # Replace with function body.

func _on_delay_timeout() -> void:
	if enemies_left_to_spawn.size() == 0:
		queue_free()
		return
	var next_enemy: PackedScene = enemies_left_to_spawn.pop_front()
	var new_enemy: Enemy = next_enemy.instantiate()
	new_enemy.global_position = global_position
	new_enemy.player = get_tree().get_first_node_in_group("player")
	get_tree().root.add_child(new_enemy)
	enemy_created.emit(new_enemy)
