class_name Player extends CharacterBody2D

@export_subgroup("Nodes")
@export var movement_component: MovementComponent
@export var jump_component: AdvancedJumpComponent
@export var input_component: InputComponent
@export var gravity_component: GravityComponent
@export var gun_component: GunComponent
@export var health_component: HealthComponent
@export var animation_component: AnimationComponent

@onready var gun: Sprite2D = $Visuals/Gun
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func on_died () -> void:
	queue_free()

func on_gun_fired () -> void:
	velocity += Vector2.from_angle(gun.global_rotation) * -100

func _ready() -> void:
	health_component.died.connect(on_died)
	gun_component.fired.connect(on_gun_fired)

func animate () -> void:
	animation_component.handle_horizontal_flip(get_global_mouse_position().x - global_position.x,false)
	if is_on_floor_only() and abs(velocity.x) > 0:
		animation_player.play("wobble")
	elif animation_player.is_playing() and animation_player.current_animation != "reset":
		animation_player.play("reset")

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self, delta)
	movement_component.handle_horizontal_movement(self,input_component.input_horizontal)
	jump_component.handle_jump(self,input_component.get_jump_input(),input_component.get_jump_input_held(),input_component.get_jump_input_released(),input_component.input_horizontal)
	gun_component.handle_gun(delta, get_global_mouse_position(),input_component.get_attack_input_held(),input_component.get_reload_input())
	animate()
	move_and_slide()
