extends LinkButton

func _on_reaction_open() -> void:
	disabled = false
	HandlerMiniFunnel.ref.reaction_open.disconnect(_on_reaction_open)

func _ready() -> void:
	HandlerMiniFunnel.ref.reaction_open.connect(_on_reaction_open)
