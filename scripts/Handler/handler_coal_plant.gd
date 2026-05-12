class_name HandlerCoalPlant
extends Node
## Passivly generates Energy every second.

## Singleton reference
static var ref : HandlerCoalPlant


## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Timer to regulate generation speed
@export var timer : Timer


func _ready() -> void:
	if Game.ref.data.stf.stf_1_forged:
		timer.start()
		return
	
	HandlerSTForge.ref.get_forged.connect(watch_for_stf_get_forged)


## Wait for CoalPlant to be purchased
func watch_for_stf_get_forged(upgrade : Upgrade) -> void:
	if upgrade == HandlerSTForge.ref.stf_1_coal_plant:
		timer.start()
		HandlerSTForge.ref.get_forged.disconnect(watch_for_stf_get_forged)


## Every second when bought
func _on_timer_timeout() -> void:
	HandlerEnergy.ref.create_energy(1)
