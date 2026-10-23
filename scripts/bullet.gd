class_name Bullet extends Area2D

@export var speed = 400 # px/sec
@export var damage = 10

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body: PhysicsBody2D):
	if "health_component" in body:
		var HC: HealthComponent = body.health_component
		HC.take_damage(damage,Vector2.ZERO,position)
	queue_free()

func _on_life_timer_timeout() -> void:
	queue_free()
