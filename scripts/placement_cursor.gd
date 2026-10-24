class_name PlacementCursor extends Marker2D

@onready var sprite_valid: Sprite2D = $SpriteValid
@onready var sprite_invalid: Sprite2D = $SpriteInvalid
@onready var validator: RayCast2D = $Validator
@onready var invalidator: Area2D = $Invalidator
@onready var roof_check: RayCast2D = $RoofCheck

func check_can_place () -> bool:
	if invalidator.get_overlapping_bodies().size() > 0 or !validator.is_colliding() or roof_check.is_colliding():
		return false
	return true

func place_troop () -> void:
	if PlayerStatus.stored_troops.size() <= 0:
		SignalBus.emit_begin_wave()
		return
	var troop_to_place: PackedScene = PlayerStatus.stored_troops.front()
	var placed_troop: CharacterBody2D = troop_to_place.instantiate()
	placed_troop.global_transform = global_transform
	placed_troop.global_position.y += -150.0
	get_tree().root.add_child.call_deferred(placed_troop,true)
	if !Settings.expend_troops: return
	PlayerStatus.stored_troops.pop_front()

func handle_placement (wants_to_place: bool) -> void:
	var can_place: bool = check_can_place()
	global_position = get_global_mouse_position()
	
	sprite_invalid.visible = !can_place
	sprite_valid.visible = can_place
	
	if can_place and wants_to_place:
		place_troop()
	
