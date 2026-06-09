class_name FuncQuizMiniGame

extends View

@export var question_label: Label
@export var graph_area: GraphArea
@export var score_label: Label
@export var hi_score_label: Label
@export var restart_button: TextureButton

@onready var buttons: Array[Button] = [
	$Margin/VBoxContainer/HBoxContainer/Button1,
	$Margin/VBoxContainer/HBoxContainer/Button2,
	$Margin/VBoxContainer/HBoxContainer/Button3,
	$Margin/VBoxContainer/HBoxContainer/Button4
]

var base_functions: Dictionary = Game.ref.data.functions.base_functions
var mod_functions: Dictionary = Game.ref.data.functions.mod_functions

var base_name: String = ""
var base_function: Callable = func(_x: float) -> float: return 0.0
var current_correct_name: String = ""
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
	
	var names: Array = base_functions.keys()
	base_name = names[randi() % names.size()]
	base_function = base_functions[base_name]
	
	var other_names: Array = mod_functions.keys()
	if other_names.has(base_name):
		other_names.erase(base_name)
	other_names.shuffle()
	
	var variants: Array = []
	
	for i: int in range(4):
		var other_name: String = other_names[randi() % other_names.size()]
		other_names.erase(other_name)
		var other_function: Callable = mod_functions[other_name]
		
		var operator_random : int = (randi() % 20)
		var combined: Callable
		var desc: String
		
		if operator_random < 3:
			combined = func(x: float) -> float: return base_function.call(x) + other_function.call(x)
			desc = base_name + " + " + other_name
		elif operator_random < 6:
			combined = func(x: float) -> float: return base_function.call(x) - other_function.call(x)
			desc = base_name + " - " + other_name
		elif operator_random < 13:
			combined = func(x: float) -> float: return base_function.call(x) * other_function.call(x)
			desc = base_name + " * " + other_name
		else:
			combined = func(x: float) -> float: return base_function.call(x) / other_function.call(x)
			desc = base_name + " / " + other_name

	
		
		variants.append({
			"text": desc,
			"func": combined
		})
	
	variants.shuffle()
	for i: int in range(buttons.size()):
		buttons[i].text = variants[i]["text"]
	
	var curent: int = randi() % variants.size()
	current_correct_name = variants[curent]["text"]
	graph_area.set_function(variants[curent]["func"], variants[curent]["text"])
	question_label.text = "Какая это функция?"


func _on_button_pressed(btn: Button) -> void:
	if not round_active or game_over:
		return
	round_active = false
	
	for b: Button in buttons:
		b.disabled = true

	var chosen: String = btn.text
	if chosen == current_correct_name:
		question_label.text = "Правильно, это была функция " + current_correct_name
		score += 1
		await get_tree().create_timer(1.0).timeout
		start_new_round()
		
	else:
		question_label.text = "Неправильно, это была функция " + current_correct_name
		game_over = true
		restart_button.visible = true
		
		if hi_score < score:
			HandlerSTR.ref.create_st_r(score - hi_score)
			hi_score = score
			hi_score_label.text = "Лучший счет: %s" % hi_score
			Game.ref.data.mini_games.func_quiz_hi_score = hi_score
	
	score_label.text = "Счет: %d" % score


func _on_restart_pressed() -> void:
	score = 0
	score_label.text = "Счет: %d" %score
	restart_button.visible = false
	start_new_round()
