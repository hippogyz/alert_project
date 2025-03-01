extends Node2D

var exhibit_mode = 0

export var default_color : Color
export var player_color : Color
export var line_width : float = 3.0
export (NodePath) onready var npc_path_nodepath
onready var npc_path = get_node(npc_path_nodepath)

func _ready() -> void:
	update()

#func _process(delta: float) -> void:
#	update()

func change_exhibit_mode(mode) -> void:
	exhibit_mode = mode
	update()

func _draw() -> void:
	if npc_path.curve == null:
		return
	match exhibit_mode:
		0:
			draw_polyline(npc_path.curve.get_baked_points(), default_color, line_width, true)
		1:
			draw_polyline(npc_path.curve.get_baked_points(), player_color, line_width , true)
		_:
			draw_polyline(npc_path.curve.get_baked_points(), default_color, line_width , true)
