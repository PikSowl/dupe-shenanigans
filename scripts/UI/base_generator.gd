class_name BaseGenerator
extends Control
## Basic generator. When on, adds 1 energy/second


@export var e_counter : Label

@export var button : Button

@export var timer : Timer

var energy : int


func _ready() -> void:
	update_label_text()


func _on_timer_timeout() -> void:
	create_energy()


func _on_button_pressed() -> void:
	begin_generating_basic_energy()


func begin_generating_basic_energy() -> void:
	timer.start()
	button.disabled = true


func create_energy() -> void:
	energy += 1
	update_label_text()


func update_label_text() -> void:
	e_counter.text = "Energy : %s" % energy
