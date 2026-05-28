extends LinkButton

func _on_simon_open() -> void:
	disabled = false
	HandlerMiniFunnel.ref.simon_open.disconnect(_on_simon_open)

func _ready() -> void:
	HandlerMiniFunnel.ref.simon_open.connect(_on_simon_open)
