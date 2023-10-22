extends Camera2D

var zoomSpd: float = 0.05
var minZoom: float = 1.0
var maxZoom: float = 2.0
var dragSen: float = 1.2

func _input(event):
	# mouse drag
	if event is InputEventMouseMotion and Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		position -= event.relative * dragSen / zoom
	
	# mouse zoom in/zoom out
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			zoom += Vector2(zoomSpd, zoomSpd)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			zoom -= Vector2(zoomSpd, zoomSpd)
		#elif event.
		zoom = clamp(zoom, Vector2(minZoom, minZoom), Vector2(maxZoom, maxZoom))


func _unhandled_input(event):
	if event is InputEventScreenDrag:
		#print('event screen drag')
		position -= event.relative * dragSen / zoom

	#if event is InputEventMagnifyGesture: 
		#var magnification = event.factor
		#if magnification > 1.0:
			#print("Zoom in: Magnification factor = ", magnification)
		#elif magnification < 1.0:
			#print("Zoom out: Magnification factor = ", magnification)
			
			
#print('event magnify')
#if event.float <= 1.0 * zoomSpd:
	#zoom -= Vector2(zoomSpd, zoomSpd)
#elif event.float > 1.0 * zoomSpd:
	#zoom += Vector2(zoomSpd, zoomSpd)
#zoom = clamp(zoom, Vector2(minZoom, minZoom), Vector2(maxZoom, maxZoom))
#var zoom_amount = event.factor.y * zoomSpd
#var new_zoom = zoom.y + zoom_amount
#if (new_zoom < maxZoom):
	#new_zoom = maxZoom
#elif (new_zoom > minZoom):
	#new_zoom = minZoom
#zoom = Vector2(new_zoom, new_zoom)

