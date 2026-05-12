class_name HandlerSTForge
extends Node
## Manage ST forge, aka STR upgrades.

## Singleton reference
static var ref : HandlerSTForge


## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


signal get_forged(upgrade : Upgrade)


@onready var stf_1_coal_plant : STF1CoalPlant = STF1CoalPlant.new()


## Returns all STForge items
func get_all_forge_items() -> Array[Upgrade]:
	return [
		stf_1_coal_plant,
	]
