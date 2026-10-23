class_name Player extends CharacterBody2D

@export_subgroup("Nodes")
@export var movement_component: MovementComponent
@export var jump_component: AdvancedJumpComponent
@export var input_component: InputComponent
@export var gravity_component: GravityComponent
@export var gun_component: GunComponent
@export var health_component: HealthComponent

func on_died () -> void:
	queue_free()

func on_gun_fired () -> void:
	print("direction_to_shot")

func _ready() -> void:
	health_component.died.connect(on_died)
	gun_component.fired.connect(on_gun_fired)

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self,input_component.input_horizontal)
	jump_component.handle_jump(self,input_component.get_jump_input(),input_component.get_jump_input_held(),input_component.get_jump_input_released(),input_component.input_horizontal)
	gun_component.handle_gun(delta, get_global_mouse_position(),input_component.get_attack_input(),input_component.get_reload_input())
	move_and_slide()
