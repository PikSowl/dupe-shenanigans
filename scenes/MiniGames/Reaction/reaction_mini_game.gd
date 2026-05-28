class_name ReactionMiniGame

extends View

@export var button_grid: GridContainer
@export var score_label: Label
@export var timer_label: Label
@export var game_timer: Timer
@export var restart_button: TextureButton


var score: int = 0
var next_expected: int = 1
var buttons_count: int = 4
var game_active: bool = false
var timer_decrease: float = 0.0
var hi_score: int = Game.ref.data.mini_games.reaction_hi_score


const BASE_TIMES: Dictionary = {
	4: 10.0,
	9: 15.0,
	16: 25.0
}


const TIME_DECREASE_PER_WIN: float = 1.5
const MIN_TIME: float = 5.0
const WINS_TO_MEDIUM: int = 4
const WINS_TO_LARGE: int = 10
const SMALL_GRID: int = 4
const MEDIUM_GRID: int = 9
const LARGE_GRID: int = 16


func _ready() -> void:
	super()
	visible = false
	timer_label.text = "Press RESTART!"


func start_game() -> void:
	score = 0
	buttons_count = 4
	game_active = true
	restart_button.visible = false
	update_score_label()
	generate_buttons()
	start_round_timer()


func generate_buttons() -> void:
	for child: Node in button_grid.get_children():
		child.queue_free()
	
	var columns: int = int(sqrt(float(buttons_count)))
	button_grid.columns = columns
	
	var numbers: Array = range(1, buttons_count + 1)
	numbers.shuffle()
	
	for num: int in numbers:
		var btn: Button = Button.new()
		btn.text = str(num)
		btn.custom_minimum_size = Vector2(160, 160)
		btn.add_theme_font_size_override("font_size", 64)
		btn.pressed.connect(_on_button_pressed.bind(num))
		button_grid.add_child(btn)
	
	next_expected = 1


func get_current_base_time() -> float:
	var time: float = BASE_TIMES.get(buttons_count, 20.0)
	return time


func get_round_time() -> float:
	var base: float = get_current_base_time()
	timer_decrease += TIME_DECREASE_PER_WIN
	var result: float = maxf(base - timer_decrease, MIN_TIME)
	return result


func start_round_timer() -> void:
	var time: float = get_round_time()
	game_timer.wait_time = time
	game_timer.start()
	update_timer_label()


func _process(_delta: float) -> void:
	if game_active and not game_timer.is_stopped():
		update_timer_label()


func update_timer_label() -> void:
	var remaining: float = game_timer.time_left
	timer_label.text = "Time: %.2f" % remaining


func update_score_label() -> void:
	score_label.text = "Score: %d" % score


func _on_button_pressed(number: int) -> void:
	if not game_active:
		return
	
	if number == next_expected:
		mark_button_as_pressed(number)
		next_expected += 1
		
		if next_expected > buttons_count:
			win_round()
	else:
		var time_remaining: float = game_timer.time_left
		game_timer.stop()
		game_timer.start(maxf(time_remaining - 1.0, 0.1))



func mark_button_as_pressed(number: int) -> void:
	for button: Button in button_grid.get_children():
		if button.text == str(number):
			button.disabled = true
			var gray_color: Color = Color(0.5, 0.5, 0.5)
			button.modulate = gray_color
			break


func win_round() -> void:
	game_timer.stop()
	score += 1
	if score == WINS_TO_LARGE:
		buttons_count = LARGE_GRID
		timer_decrease = 0
	
	elif score == WINS_TO_MEDIUM:
		buttons_count = MEDIUM_GRID
		timer_decrease = 0

	update_score_label()
	generate_buttons()
	start_round_timer()


func game_over() -> void:
	if not game_active:
		return
	game_active = false
	game_timer.stop()
	timer_label.text = "Times up!"
	restart_button.visible = true
	
	if hi_score < score:
		HandlerSTR.ref.create_st_r(score - hi_score)
		hi_score = score
		Game.ref.data.mini_games.reaction_hi_score = hi_score
	
	for button: Button in button_grid.get_children():
		button.disabled = true


func _on_restart_pressed() -> void:
	start_game()


func _on_timer_timeout() -> void:
	game_over()
