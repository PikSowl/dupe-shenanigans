class_name Upgrade
extends Node
## Abstact class defining a upgrade.


## Emited when upgrade is bought
signal bought


## Is it forged
var is_forged : bool = false
## How many times was it forged
var times_forged : int = 0
## Name of upgrade
var title : String = ""
## What it does
var description : String
## How much for first one
var base_cost : int = -1
## How much for one
var cost : int = -1


## Вирутальный класс, должен быть переопределен.[br]
## Returns upgrade description and cost
func get_description() -> String:
	return "Описание отсутствует."


## Virtual class, must be overwritten.[br]
## Returns how much for one
func calculate_cost() -> void:
	printerr("calculate_cost() не определен")


## Virtual class, must be overwritten.[br]
func is_afordable() -> bool:
	return false

## Virtual class, must be overwritten.[br]
func buy_one() -> void:
	printerr("buy_one() не определен")
