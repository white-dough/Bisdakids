extends Camera2D

#var zoom_min = Vector2(.1000001, .1000001)
#var zoom_max = Vector2(2.5000001, 2.5000001)
#var zoom_speed = Vector2(.3000001, .3000001)

#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseButton:
		#if event.is_pressed():
			#if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				#if zoom > zoom_min:
					#zoom -= zoom_speed
					#pass
			#if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				#if zoom < zoom_max:
					#zoom += zoom_speed
	#pass

#var _target_zoom: float = 1.0
#const MIN_ZOOM: float = 0.1
#const MAX_ZOOM: float = 1.0
#const ZOOM_INCREMENT: float = 0.1
#const ZOOM_RATE: float = 8.0

#func _unhandled_input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		#if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			#position -= event.relative * zoom
	#if event is InputEventMouseButton:
		#if event.is_pressed():
			#if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				#zoom_in()
			#if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				#zoom_out()

#func zoom_in() -> void:
	#_target_zoom = max(_target_zoom - ZOOM_INCREMENT, MIN_ZOOM)
	#set_physics_process(true)

#func zoom_out() -> void:
	#_target_zoom = min(_target_zoom + ZOOM_INCREMENT, MAX_ZOOM)
	#set_physics_process(true)

#func _physics_process(delta: float) -> void:
	#zoom = lerp(
		#zoom,
		#_target_zoom * Vector2.ONE,
		#ZOOM_RATE * delta
	#)
	#set_physics_process(
		#not is_equal_approx(zoom.x, _target_zoom)
	#)

var zoomSpd: float = 0.05
var minZoom: float = 1.0
var maxZoom: float = 2.0
var dragSen: float = 1.2

func _input(event):
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		position -= event.relative * dragSen / zoom
		
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoomSpd, zoomSpd)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoomSpd, zoomSpd)
		zoom = clamp(zoom, Vector2(minZoom, minZoom), Vector2(maxZoom, maxZoom))
	
