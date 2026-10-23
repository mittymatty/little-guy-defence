class_name ArmyMan extends CharacterBody2D

@export_subgroup("Nodes")
@export var movement_component: MovementComponent
@export var gravity_component: GravityComponent
@export var tracker_component: TrackerComponent
@export var animation_component: AnimationComponent
@export var gun_component: GunComponent

@export var drop_chute_raycast: RayCast2D
@export var parachute: Sprite2D

var is_parachute_attached: bool = true
var last_target_pos: Vector2 = Vector2.ZERO

func get_nearest_node_in_group(group):
	var nodes = get_tree().get_nodes_in_group(group)
	nodes.sort_custom(func(a,b): return a.global_position.distance_to(global_position)<b.global_position.distance_to(global_position) )
	return nodes.front() if nodes.size() > 0 else null

func handle_parachute () -> void:
	if drop_chute_raycast.is_colliding():
		is_parachute_attached = false
		parachute.visible = false

func _physics_process(delta: float) -> void:
	tracker_component.tracker_target = get_nearest_node_in_group("enemies")
	if !is_parachute_attached:
		gravity_component.handle_gravity(self,delta)
	else:
		velocity.y = 50
		handle_parachute()
	
	movement_component.handle_horizontal_movement(self,0.0)
	var should_reload: bool = gun_component.ammo == 0 or gun_component.ammo < gun_component.max_ammo and !tracker_component.tracker_target

	if tracker_component.tracker_target:
		var flip_horizontal: float = tracker_component.tracker_target.global_position.x - global_position.x
		animation_component.handle_horizontal_flip(flip_horizontal,false)
		gun_component.handle_gun(delta,tracker_component.tracker_target.global_position,true,should_reload)
		last_target_pos = tracker_component.tracker_target.global_position
	elif should_reload:
			gun_component.handle_gun(delta,last_target_pos,false,true)

	
	move_and_slide()
