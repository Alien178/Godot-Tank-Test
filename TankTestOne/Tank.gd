extends KinematicBody2D

onready var velocity : Vector2 = Vector2(0, 0)
onready var tank_body_sprite: Sprite = $TankBody/Body
#onready var tank_barrel_sprite: Sprite = $TankBody/Barrel
onready var left_barrel_position: Position2D = $TankBody/Left
onready var right_barrel_position: Position2D = $TankBody/Right
onready var BULLET : PackedScene = load("res://TankTestOne/Bullet.tscn")
onready var barrel_shoot_position: Position2D = $TankBody/Gobal/Shoot
onready var barrel_shoot_position_parent: Position2D = $TankBody/Gobal

const SPEED = 100
const GRAVITY = 10

export (String) var direction := "Left"
export (float) var barrel_rotation = 0

var shooting : bool = false

func _physics_process(_delta):
	if Input.is_action_pressed("right"):
		velocity.x = SPEED
		tank_body_sprite.flip_h = true
		#tank_barrel_sprite.flip_h = true
		#tank_barrel_sprite.position = right_barrel_position.position
		#tank_barrel_sprite.offset.x = 48
		direction = "Right"
		#tank_barrel_sprite.rotation_degrees = -barrel_rotation
		barrel_shoot_position_parent.position = right_barrel_position.position
		barrel_shoot_position_parent.rotation_degrees = barrel_rotation * -barrel_rotation
		
	elif Input.is_action_pressed("left"):
		velocity.x = -SPEED
		tank_body_sprite.flip_h = false
		#tank_barrel_sprite.flip_h = false
		#tank_barrel_sprite.position = left_barrel_position.position
		#tank_barrel_sprite.offset.x = -48
		direction = "Left"
		#tank_barrel_sprite.rotation_degrees = barrel_rotation
		barrel_shoot_position_parent.position = left_barrel_position.position
		barrel_shoot_position_parent.rotation_degrees = barrel_rotation
	
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)

func _on_HSlider_value_changed(value):
	if direction == "Right":
		#tank_barrel_sprite.rotation_degrees = -value
		barrel_shoot_position_parent.rotation_degrees = -value
		barrel_rotation = -barrel_shoot_position_parent.rotation_degrees
	else:
		#tank_barrel_sprite.rotation_degrees = value
		barrel_shoot_position_parent.rotation_degrees = value
		barrel_rotation = value

func _unhandled_key_input(event) -> void:
	if event.is_action_pressed("attack"):
		shoot()

func shoot() -> void:
	var bullet = BULLET.instance()
	
	if direction == "Right":
		bullet.set_bullet_direction(1)
	else:
		bullet.set_bullet_direction(-1)
	
	get_parent().add_child(bullet)
	bullet.position = barrel_shoot_position.global_position
