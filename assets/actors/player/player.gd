extends KinematicBody2D

signal try_take_alert_signal()
signal reduce_rest_time_signal()
signal change_sight_signal(sight_index)

enum Exhibit {DEFAULT = 0, PLAYER = 1}

export var move_speed : float = 500.0
var _velocity : Vector2 = Vector2.ZERO

onready var affect_area = get_node("AffectArea")

var has_rest_time : bool
var exhibit_mode

func _ready() -> void:
	connect("try_take_alert_signal", affect_area, "awake_affect_area")
	affect_area.connect("awake_affect_area_signal",self,"reduce_rest_time")
	has_rest_time = true
	exhibit_mode = 0


func _physics_process(delta: float) -> void:
	_handle_input()
	_velocity = _get_direction() * move_speed
	move_and_slide(_velocity)


func _get_direction() -> Vector2 :
	var x_dir = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y_dir = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	return Vector2(x_dir, y_dir).normalized()

func _handle_input() -> void:
	if Input.is_action_just_pressed("take_alert") && has_rest_time:
		emit_signal("try_take_alert_signal")
	if Input.is_action_just_pressed("special_sight"):
		emit_signal("change_sight_signal", 1)
	if Input.is_action_just_released("special_sight"):
		emit_signal("change_sight_signal", 0)
	#some other input...

func reduce_rest_time() -> void:
	emit_signal("reduce_rest_time_signal")

func forbid_take_alert() -> void:
	has_rest_time = false

func permit_take_alert() -> void:
	has_rest_time = true

func change_exhibit_mode(mode) -> void:
	exhibit_mode = mode
