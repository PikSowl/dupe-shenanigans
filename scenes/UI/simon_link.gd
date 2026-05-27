extends LinkButton

func _on_simon_open() -> void:
	disabled = false
	HandlerMiniFunel.ref.simon_open.disconnect(_on_simon_open)

func _ready() -> void:
	HandlerMiniFunel.ref.simon_open.connect(_on_simon_open)
