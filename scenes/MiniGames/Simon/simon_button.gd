class_name SimonButton
extends TextureButton

signal pressed_color(color : Color)

@export var color_name: String = ""


func _ready() -> void:
	pressed.connect(_on_pressed)

func _on_pressed()-> void:
	disabled = true
	emit_signal("pressed_color", color_name)
	disabled = false

func highlight()-> void:
	texture_normal = texture_pressed

func unhighlight()-> void:
	texture_normal = texture_focused
