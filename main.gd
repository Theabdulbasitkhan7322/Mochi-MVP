extends Node2D

var is_inside = false
var screen_size

func _ready():
	screen_size = DisplayServer.screen_get_size()
	$ColorRect.position = Vector2(0, 0)
	$ColorRect.size = screen_size
	$HTTPRequest.connect("request_completed", _on_weather_received)
	fetch_weather()

func fetch_weather():
	var url = "https://api.open-meteo.com/v1/forecast?latitude=28.5706&longitude=77.3272&current_weather=true"
	$HTTPRequest.request(url)

func _on_weather_received(result, response_code, headers, body):
	if response_code == 200:
		var json = JSON.new()
		json.parse(body.get_string_from_utf8())
		var data = json.get_data()
		var weather_code = data["current_weather"]["weathercode"]
		print("Weather code received: ", weather_code)
		apply_weather(weather_code)
	else:
		print("Weather fetch failed: ", response_code)

func apply_weather(code):
	if code == 0:
		$ColorRect.color = Color(0.53, 0.81, 0.98)
		print("Clear sky")
	elif code <= 3:
		$ColorRect.color = Color(0.74, 0.74, 0.74)
		print("Cloudy")
	elif code <= 67:
		$ColorRect.color = Color(0.40, 0.40, 0.55)
		print("Rainy")
	elif code <= 77:
		$ColorRect.color = Color(0.85, 0.92, 0.98)
		print("Snowy")
	else:
		$ColorRect.color = Color(0.30, 0.30, 0.40)
		print("Storm")

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.keycode == KEY_SPACE:
			toggle_mode()

func toggle_mode():
	is_inside = !is_inside
	if is_inside:
		$ColorRect.color = Color(0.15, 0.15, 0.20)
		$MochiPlaceholder.scale = Vector2(1.5, 1.5)
		print("INSIDE MODE")
	else:
		fetch_weather()
		$MochiPlaceholder.scale = Vector2(1.0, 1.0)
		print("OUTSIDE MODE")
