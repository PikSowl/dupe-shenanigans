class_name BaseClicker
extends Control
## Basic clicker. Click on button == +1 energy.


@export var e_counter : Label

@export var ui : UI

@export var view : UI.Views


func _ready() -> void:
	update_label_text()
	
	visible = true
		
	ui.navigation_requested.connect(_on_navigation_request)


## TEMP Function to update label
func _process(_delta: float) -> void:
	update_label_text()


func _on_button_pressed() -> void:
	create_energy()


func create_energy() -> void:
	Game.ref.data.energy += 1


func update_label_text() -> void:
	e_counter.set_text("Energy : %s" % Game.ref.data.energy)
	

func _on_navigation_request(requested_view : UI.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false
