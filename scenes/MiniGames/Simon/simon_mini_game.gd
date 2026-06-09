class_name SimonMiniGame
extends View
## View displaying Simin mini-game

## Current state of mini-game
enum State { IDLE, SHOWING_SEQUENCE, PLAYER_TURN, GAME_OVER }
var current_state : State = State.IDLE

## Right button combination
var sequence: Array = []

var player_input_index: int = 0

var score: int = 0
var hi_score : int = Game.ref.data.mini_games.simon_hi_score
var index: int = 0

@export var score_label: Label
@export var hi_score_label: Label
@export var message_label : Label
@export var sequence_timer: Timer
@export var restart_button : TextureButton

## Buttons for mini-game
@export var green_button : SimonButton
@export var yellow_button : SimonButton
@export var blue_button : SimonButton
@export var red_button : SimonButton

var curent_button : SimonButton

@onready var buttons : Array = [
	green_button,
	yellow_button,
	blue_button,
	red_button
]


func _ready() -> void:
	super()
	visible = false
	_connect_button_signals()
	current_state = State.GAME_OVER
	disable_buttons()
	hi_score_label.text = "Лучший счет: %s" % hi_score
	message_label.text = "Готов? Жми Рестарт"


func _connect_button_signals() -> void:
	for button : SimonButton  in buttons:
		button.pressed_color.connect(_on_button_pressed)


## On game start clear previous results
func start_new_game() -> void:
	sequence.clear()
	score = 0
	update_score_label()
	message_label.text = ""
	current_state = State.IDLE
	add_to_sequence()


## Добавляет новую кнопку в последовательность
func add_to_sequence() -> void:
	var random_button : SimonButton = buttons[randi() % buttons.size()]
	sequence.append(random_button)
	await(get_tree().create_timer(0.5).timeout)
	show_sequence()


##Shows correct generated button sequence
func show_sequence() -> void:
	current_state = State.SHOWING_SEQUENCE
	message_label.text = "Запоминай..."
	disable_buttons()
	index = 0
	while index < sequence.size():
		curent_button = sequence[index]
		curent_button.highlight()
		await get_tree().create_timer(0.4).timeout # длительность подсветки
		curent_button.unhighlight()
		await get_tree().create_timer(0.2).timeout # пауза между кнопками
		index += 1
	start_player_turn()

func start_player_turn() -> void:
	current_state = State.PLAYER_TURN
	player_input_index = 0
	message_label.text = "Повтори!"
	enable_buttons()


func _on_button_pressed(color_name : String) -> void:
	if current_state != State.PLAYER_TURN:
		return

	var pressed_button : SimonButton = _get_button_by_color(color_name)
	if not pressed_button:
		return

	if pressed_button == sequence[player_input_index]:
		player_input_index += 1
		if player_input_index >= sequence.size():
			score += 1
			update_score_label()
			message_label.text = "Правильно!"
			disable_buttons()
			await get_tree().create_timer(1.0).timeout
			add_to_sequence()
	else:
		game_over()



func game_over() -> void:
	current_state = State.GAME_OVER
	disable_buttons()
	message_label.text = "Неправильно."
	update_score_label()
	
	if hi_score < score:
		HandlerSTR.ref.create_st_r(score - hi_score)
		hi_score = score
		hi_score_label.text = "Лучший счет: %s" % hi_score
		Game.ref.data.mini_games.simon_hi_score = hi_score
	
	restart_button.visible = true


func _on_texture_button_pressed() -> void:
	restart_button.visible = false
	start_new_game()


func enable_buttons() -> void:
	for button : SimonButton in buttons:
		button.disabled = false


func disable_buttons() -> void:
	for button : SimonButton in buttons:
		button.disabled = true


func _get_button_by_color(color_name: String) -> SimonButton:
	for button : SimonButton in buttons:
		if button.color_name == color_name:
			return button
	return null


func update_score_label() -> void:
	score_label.text = "Счет: %d" % score
