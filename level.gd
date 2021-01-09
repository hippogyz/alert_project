extends Node2D

onready var player_m = get_node("player")
onready var npc_list = get_node("NPCList").get_children()

func _physics_process(delta: float) -> void:
	for npc in npc_list:
			npc.get_node("Ball").cut_rest_life_time(delta)
	
	for npc in npc_list:
		npc.get_node("Ball").cal_next_state()
	
	for npc in npc_list:
		npc.get_node("Ball").update_state()
	
