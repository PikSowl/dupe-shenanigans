class_name BaseUpgrade
extends Control
## Shows upgrades

@export var ui : UI

@export var view : UI.Views


func _ready() -> void:
	visible = false
		
	ui.navigation_requested.connect(_on_navigation_request)


func _on_navigation_request(requested_view : UI.Views) -> void:
	if requested_view == view:
		visible = true
		return
	
	visible = false
