class_name Enemy extends CharacterBody2D

@export var player: CharacterBody2D

@export_subgroup("Nodes")
@export var movement_component: MovementComponent
@export var gravity_component: GravityComponent
@export var tracker_component: TrackerComponent
@export var health_component: HealthComponent
@export var jump_component: JumpComponent
@export var jump_detector_component: JumpDetectorComponent
@export var animation_component: AnimationComponent

func _ready() -> void:
	tracker_component.tracker_target = player
	health_component.damaged.connect(on_damaged)
	health_component.died.connect(on_died)

func on_damaged(_damage_taken: float) -> void:
	damage_flash()

func damage_flash() -> void:
	var red_flash: Tween = create_tween()
	var white_flash: Tween = create_tween()
	
	white_flash.tween_property(self,"modulate:v",1,0.1).from(15)
	red_flash.tween_property(self, "modulate:s", 0, 0.1).from(15)

func on_died () -> void:
	queue_free()

func _physics_process(delta: float) -> void:
	gravity_component.handle_gravity(self,delta)
	movement_component.handle_horizontal_movement(self,tracker_component.movement_horizontal)
	jump_component.handle_jump(self,jump_detector_component.check_if_should_jump())
	animation_component.handle_horizontal_flip(velocity.x,false)
	move_and_slide()
