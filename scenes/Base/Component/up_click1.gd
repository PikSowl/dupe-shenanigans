class_name UpClick1
extends Upgrade
## Upgrade for click number 1. Increase energy from clicks.


func _init() -> void:
	times_forged = Game.ref.data.up_c_1_amount
	title = "Улучшение Кликера"
	base_cost = 5
	calculate_cost()
	description = get_description()
	bought.emit()


## Returns upgrade description and cost
func get_description() -> String:
	var desc : String = "Увеличивает Энергию с нажатия."
	desc += "\nЭффект : +1 Энергия/клик"
	desc += "\nСтоимость в Энергии: %s" %cost
	
	return desc


func is_afordable() -> bool:
	if HandlerEnergy.ref.energy() >= cost:
		return true
	
	return false


## Возращает стоимость одного улучшения
func calculate_cost() -> void:
	cost = base_cost + 2 * base_cost * int(times_forged**1.3)
	description = get_description()

## Покупает одно улучшение
func buy_one() -> void:
	if not HandlerEnergy.ref.consume_energy(cost):
		times_forged += 1
		Game.ref.data.up_c_1_amount = times_forged
		calculate_cost()
		
		bought.emit()
