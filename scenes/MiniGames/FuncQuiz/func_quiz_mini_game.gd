class_name FuncQuizMiniGame

extends View

@export var question_label: Label
@export var graph_area: GraphArea
@export var score_label: Label
@export var restart_button: TextureButton

@onready var buttons: Array[Button] = [
	$VBoxContainer/HBoxContainer/Button1,
	$VBoxContainer/HBoxContainer/Button2,
	$VBoxContainer/HBoxContainer/Button3,
	$VBoxContainer/HBoxContainer/Button4
]

var functions: Dictionary = Game.ref.data.functions.functions

var current_function_name: String = ""
var current_function: Callable = func(_x: float) -> float: return 0.0
var score: int = 0
var hi_score: int = Game.ref.data.mini_games.func_quiz_hi_score
var round_active: bool = true
var game_over: bool = false


func _ready() -> void:
	super()
	visible = false
	for btn: Button in buttons:
		btn.pressed.connect(_on_button_pressed.bind(btn))
	start_new_round()


func start_new_round() -> void:
	game_over = false
	round_active = true
	restart_button.visible = false
	
	for btn: Button in buttons:
		btn.disabled = false
	
	var keys: Array = functions.keys()
	current_function_name = keys[randi() % keys.size()]
	current_function = functions[current_function_name]
	var other: Array = keys.duplicate()
	other.erase(current_function_name)
	other.shuffle()
	var variants: Array = other.slice(0, 3)
	variants.append(current_function_name)
	variants.shuffle()
	
	for i: int in range(buttons.size()):
		buttons[i].text = variants[i]
		
	graph_area.set_function(current_function, current_function_name)
	question_label.text = "Wich function is it?"


func _on_button_pressed(btn: Button) -> void:
	if not round_active or game_over:
		return
	round_active = false
	
	for b: Button in buttons:
		b.disabled = true

	var chosen: String = btn.text
	if chosen == current_function_name:
		question_label.text = "Right! That was function " + current_function_name
		score += 1
		# Wait 2 sec and start new round
		await get_tree().create_timer(2.0).timeout
		start_new_round()
		
	else:
		question_label.text = "WRONG! Right function was " + current_function_name
		game_over = true
		restart_button.visible = true
		restart_button.disabled = false
		
		if hi_score < score:
			HandlerSTR.ref.create_st_r(score - hi_score)
			hi_score = score
			Game.ref.data.mini_games.simon_hi_score = hi_score
	
	score_label.text = "Score: %d" % score
	
	


func _on_restart_pressed() -> void:
	score = 0
	score_label.text = "Score: %d" %score
	restart_button.disabled = true
	restart_button.visible = false
	start_new_round()
