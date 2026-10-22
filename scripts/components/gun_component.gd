class_name GunComponent extends Node

@export_subgroup("Nodes")
@export var gun_visuals: Node2D
@export var muzzle: Marker2D

@export_subgroup("Scenes")
@export var Bullet : PackedScene

@export_subgroup("Configuration")
@export var rotation_speed: float = 50.0

func handle_gun (delta: float, target_pos: Vector2, wants_to_shoot: bool) -> void:
	rotate_to_target(delta, target_pos)
	if wants_to_shoot:
		shoot()

func rotate_to_target (_delta: float, target_pos: Vector2) -> void:
	gun_visuals.look_at(target_pos)

func shoot () -> void:
	var b = Bullet.instantiate()
	get_tree().root.add_child(b)
	b.transform = muzzle.global_transform
