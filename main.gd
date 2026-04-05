extends Node2D

var is_inside = true

@onready var room_bg = $RoomBackground
@onready var window_mask = $Polygon2D
@onready var video_player = $Polygon2D/VideoStreamPlayer
@onready var mochi = $MochiPlaceholder

# Preload your DAY videos
var clear_day = preload("res://assets/skyclip.ogv")
# var rain_day = preload("res://assets/rain_day.ogv") # Add this later!

# Preload your NIGHT videos
var clear_night = preload("res://assets/NightTime.ogv")
# var rain_night = preload("res://assets/rain_night.ogv") # Add this later!

func _ready():
	# Apply performance optimizations for the laptop battery
	Engine.max_fps = 30 
	
	$HTTPRequest.connect("request_completed", _on_weather_received)
	fetch_weather()

func fetch_weather():
	var url = "https://api.open-meteo.com/v1/forecast?latitude=28.5706&longitude=77.3272&current_weather=true"
	$HTTPRequest.request(url)

func _on_weather_received(_result, response_code, _headers, body):
	if response_code == 200:
		var json = JSON.new()
		var error = json.parse(body.get_string_from_utf8())
		if error == OK:
			var data = json.data
			var weather_code = data["current_weather"]["weathercode"]
			var is_day = data["current_weather"]["is_day"] # 1 = Day, 0 = Night
			
			print("Weather code: ", weather_code, " | Is Day: ", is_day)
			apply_weather(weather_code, is_day)
		else:
			print("JSON Parse Error")
	else:
		print("Weather fetch failed: ", response_code)

func apply_weather(code, is_day):
	if is_day == 1:
		# --- DAYTIME LOGIC ---
		if code == 0:
			video_player.stream = clear_day
			print("Playing Day: Clear")
		elif code <= 67:
			# video_player.stream = rain_day
			print("Playing Day: Rainy")
	else:
		# --- NIGHTTIME LOGIC ---
		if code == 0:
			video_player.stream = clear_night
			print("Playing Night: Clear")
		elif code <= 67:
			# video_player.stream = rain_night
			print("Playing Night: Rainy")
			
	# Play the selected video
	if video_player.stream != null:
		video_player.play()

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			toggle_mode()

func toggle_mode():
	is_inside = !is_inside
	if is_inside:
		room_bg.visible = true
		window_mask.visible = true
		mochi.scale = Vector2(1.0, 1.0)
	else:
		room_bg.visible = false
		window_mask.visible = false
		mochi.scale = Vector2(1.5, 1.5)
