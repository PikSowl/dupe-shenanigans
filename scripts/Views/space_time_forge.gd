class_name SpaceTimeForge
extends View
## View displaying upgrades forged from STR

@export var stf_area : Control

@export var comp_upgrade_scene : PackedScene

func _ready() -> void:
	super()
	visible = false
	initialize_forge()


func initialize_forge() -> void:
	var items : Array[Upgrade] = HandlerSTForge.ref.get_all_forge_items()
	
	if items.size() < 1:
		return
	
	for item : Upgrade in items:
		var item_node : ComponentUpgrade = comp_upgrade_scene.instantiate() as ComponentUpgrade
		
		item_node.upgrade = item
		
		stf_area.add_child(item_node)
