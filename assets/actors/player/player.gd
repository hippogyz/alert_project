extends KinematicBody2D

signal take_alert_signal()

export var move_speed : float = 500.0
var _velocity : Vector2 = Vector2.ZERO

onready var affect_area = get_node("AffectArea")

func _ready() -> void:
	connect("take_alert_signal", affect_area, "awake_affect_area")


func _physics_process(delta: float) -> void:
	_handle_input()
	_velocity = _get_direction() * move_speed
	move_and_slide(_velocity)


func _get_direction() -> Vector2 :
	var x_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_dir = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_dir, y_dir).normalized()

func _handle_input() -> void:
	if Input.is_action_just_pressed("take_alert"):
		emit_signal("take_alert_signal")
	#some other input...

