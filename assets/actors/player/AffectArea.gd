extends Area2D

signal awake_affect_area_signal()

onready var area_sprite = get_node("AffectAreaSprite")
onready var area_collision = get_node("AffectAreaShape")

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
	if !is_awake:
		is_awake = true
		area_sprite.visible = true
		area_collision.disabled = false
		awake_time = awake_max_time
		emit_signal("awake_affect_area_signal")
		$AnimationPlayer.play("Alert")

func _stop_affect_area() -> void:
	is_awake = false
	area_sprite.visible = false
	area_collision.disabled = true

func change_and_play_audio(audio_path : String) -> void:
	$AudioStreamPlayer2D.stream = load(audio_path)
	$AudioStreamPlayer2D.play()
