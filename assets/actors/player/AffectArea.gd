extends Area2D

export (NodePath) onready var area_sprite_path
export (NodePath) onready var area_collision_path

onready var area_sprite = get_node(area_sprite_path)
onready var area_collision = get_node(area_collision_path)

var is_awake
export var awake_max_time : float = 1.0
var awake_time : float = 0.0

func _ready() -> void:
	_stop_affect_area()
	

func _physics_process(delta: float) -> void:
	if is_awake:
		if awake_time > 0:
			awake_time -= delta
		else:
			_stop_affect_area()

func awake_affect_area() -> void:
	is_awake = true
	area_sprite.visible = true
	area_collision.disabled = false
	awake_time = awake_max_time

func _stop_affect_area() -> void:
	is_awake = false
	area_sprite.visible = false
	area_collision.disabled = true
