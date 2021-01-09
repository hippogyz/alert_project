extends "res://assets/actors/npc/PathFollow2D.gd"

#export var affect_area_radius : int = 150
export var impact_factor : float = 0.5
export var threshod : float = 0.4
export var life_time : float = 3.0
var is_playing_animation : bool = false
var rest_life_time : float = 0
var exhibit_mode

onready var animation_player = get_node("AnimationPlayer")
onready var detector_area = get_node("DetectorArea")
onready var affect_area = get_node("AffectArea")

var is_alerted = false
var next_state = false

func _ready():
	exhibit_mode = 0
	#affect_area.get_node("CollisionShape2D").radius = affect_area_radius


func alerted() -> void:
	if !is_alerted:
		is_alerted = true
		rest_life_time = life_time
		animation_player.play("TureAlerted")

func fade() -> void:
	if is_alerted:
		is_alerted = false
		animation_player.play("TureClam")

func cut_rest_life_time(delta:float) -> void:
		if is_alerted:
			rest_life_time -= delta
			if rest_life_time <= 0:
				print("%s: time fade" % get_owner().get_name())
				fade()

func cal_next_state() -> void: # return the next frame's alerted state
	if is_playing_animation:
		next_state = is_alerted
		return
	
	var overlap_area = detector_area.get_overlapping_areas()
	var temp_factor : float = 0
	var temp_count : int = 0
	
	for area in overlap_area:
		if area.owner.name == "player":
			rest_life_time = life_time
			next_state = true
			return
		
		if area.owner != self && !area.owner.is_playing_animation:
			temp_factor += area.owner.impact_factor if area.owner.is_alerted else 0
			temp_count += 1
	
	if temp_count == 0:
		next_state = is_alerted
		return
	else:
		temp_factor /= float(temp_count)
		if (is_alerted && temp_factor >= 1 - threshod) || (!is_alerted && temp_factor > threshod):
			next_state = true
			return
		else:
			next_state = false
			return

func update_state() -> void :
	if next_state:
		alerted()
	else:
		fade()

func judge_victory() -> bool:
	if !is_playing_animation && is_alerted:
		return true
	else:
		return false

func change_exhibit_mode(mode) -> void:
	exhibit_mode = mode
