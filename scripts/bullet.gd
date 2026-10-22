extends Area2D

@export var speed = 750 # px/sec
@export var damage = 10

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_Bullet_body_entered(body: PhysicsBody2D):
	if body.has("health_component"):
		print("ss")
		var HC: HealthComponent = body.health_component
		HC.take_damage(damage,Vector2.ZERO,position)
	queue_free()
	
