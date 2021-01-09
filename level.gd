extends Node2D

signal game_over_signal()
signal victory_signal()

export var game_over_waiting_time : float = 10.0
var is_game_over : bool
var is_victory : bool

export var max_try_time : int = 10
var rest_try_time : int

onready var player_m = get_node("player")
onready var npc_list = get_node("NPCList").get_children()

func _ready() -> void:
	is_game_over = false
	is_victory = false
	rest_try_time = max_try_time
	player_m.connect("reduce_rest_time_signal",self, "reduce_rest_time")
	

func _physics_process(delta: float) -> void:
	_update_npc_state(delta)
	_judge_victory()
	_judge_game_over(delta)

func reduce_rest_time() -> void:
	rest_try_time -= 1
	if rest_try_time == 0: 
		is_game_over = true
		player_m.forbid_take_alert()

func _restart() -> void:
	rest_try_time = max_try_time
	is_game_over = false
	player_m.permit_take_alert()

func _update_npc_state(delta:float) -> void :
	for npc in npc_list:
		npc.get_node("Ball").cut_rest_life_time(delta)
	
	for npc in npc_list:
		npc.get_node("Ball").cal_next_state()
	
	for npc in npc_list:
		npc.get_node("Ball").update_state()

func _judge_victory() -> void:
	if is_victory: 
		return 
	
	var result = true
	for npc in npc_list:
		result = result && npc.get_node("Ball").judge_victory()
	
	if result:
		is_victory = true
		emit_signal("victory_signal")

func _judge_game_over(delta:float) -> void:
		if is_game_over && game_over_waiting_time > 0 && !is_victory:
			game_over_waiting_time -= delta
			if game_over_waiting_time <= 0:
				print("game over")
				emit_signal("game_over_signal")
