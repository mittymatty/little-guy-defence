class_name GunComponent extends Node

@export_subgroup("Scenes")
@export var bullet : PackedScene

@export_subgroup("Nodes")
@export var gun_visuals: Node2D
@export var muzzle: Marker2D
@export var cooldown_timer: Timer
@export var reload_timer: Timer

@export_subgroup("Configuration")
@export var max_ammo: int = 10
@export var starter_ammo: int = 10

signal fired (direction_to_shot: Vector2)

func handle_gun (delta: float, target_pos: Vector2, wants_to_shoot: bool, _wants_to_reload: bool) -> void:
	rotate_to_target(delta, target_pos)
	if wants_to_shoot and cooldown_timer.is_stopped():
		cooldown_timer.start()
		shoot()

func rotate_to_target (_delta: float, target_pos: Vector2) -> void:
	gun_visuals.look_at(target_pos)

func shoot () -> void:
	var b = bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = muzzle.global_transform
	fired.emit()
