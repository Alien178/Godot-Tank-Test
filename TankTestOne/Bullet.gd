extends Area2D
class_name Bullet

const SPEED = 100
onready var _velocity : Vector2 = Vector2()
var _direction = -1

func set_bullet_direction(dir):
	_direction = dir

func _physics_process(delta: float) -> void:
	_velocity.x = SPEED * delta * _direction
	translate(_velocity)

func _on_VisibilityNotifier2D_viewport_exited(_viewport: Viewport) -> void:
	queue_free()

