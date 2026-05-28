extends LinkButton

func _on_func_quiz_open() -> void:
	disabled = false
	HandlerMiniFunnel.ref.func_quiz_open.disconnect(_on_func_quiz_open)

func _ready() -> void:
	HandlerMiniFunnel.ref.func_quiz_open.connect(_on_func_quiz_open)
