class_name HandlerCoalPlant
extends Node
## Passivly generates Energy every second.

## Singleton reference
static var ref : HandlerCoalPlant

#How many energy is generated from Coal Plant
var gen_power : int = 1

## Singleton check
func _enter_tree() -> void:
	if not ref:
		ref = self
		return
	
	queue_free()


## Timer to regulate generation speed
@export var timer : Timer


func _ready() -> void:
	calculate_gen_power()
	HandlerSTForge.ref.get_forged.connect(watch_for_stf_get_forged)
	
	if Game.ref.data.stf.stf_1_forged:
		timer.start()
		return
	
	HandlerSTForge.ref.stf_1_coal_plant.bought.connect(watch_for_stf_1_get_forged)

## Every second if bought
func _on_timer_timeout() -> void:
	HandlerEnergy.ref.create_energy(gen_power)


## Wait for CoalPlant to be purchased
func watch_for_stf_1_get_forged() -> void:
	timer.start()
	HandlerSTForge.ref.stf_1_coal_plant.bought.disconnect(watch_for_stf_1_get_forged)


## Check if power changed after forging
func watch_for_stf_get_forged() -> void:
	calculate_gen_power()


## Calculate how much to generate every cycle
func calculate_gen_power() -> void:
	gen_power = int(pow(2, Game.ref.data.stf.stf_2_times_forged))
