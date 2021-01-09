extends Path2D

enum Exhibit {DEFAULT = 0, PLAYER = 1}

var exhibit_mode = Exhibit.DEFAULT

export var default_color : Color
export var player_color : Color
export var line_width : float = 3.0


func _ready() -> void:
	update()

func _process(delta: float) -> void:
	update()

func change_exhibit_mode(mode) -> void:
	exhibit_mode = mode
	update()

func _draw() -> void:
	if curve == null:
		return
	match exhibit_mode:
		Exhibit.DEFAULT:
			draw_polyline(curve.get_baked_points(), default_color, line_width, true)
		Exhibit.PLAYER:
			draw_polyline(curve.get_baked_points(), player_color, line_width , true)
		_:
			draw_polyline(curve.get_baked_points(), default_color, line_width , true)
