extends LinkButton

func _on_func_quiz_open() -> void:
	disabled = false
	HandlerMiniFunel.ref.func_quiz_open.disconnect(_on_func_quiz_open)

func _ready() -> void:
	HandlerMiniFunel.ref.func_quiz_open.connect(_on_func_quiz_open)
