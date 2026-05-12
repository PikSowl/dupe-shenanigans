class_name Upgrade
extends Node
## Abstact class defining a upgrade.


## Emited when upgrade is bought
signal bought


## How many already bought
var amount : int = -1
## Is it forged
var is_forged : bool = false
## Name of upgrade
var title : String = "Click Upgrade"
## What it does
var description : String
## How much for first one
var base_cost : int = -1
## How much for one
var cost : int = -1


## Virtual class, must be overwritten.[br]
## Returns upgrade description and cost
func get_description() -> String:
	return "Description missing."


## Virtual class, must be overwritten.[br]
## Returns how much for one
func calculate_cost() -> void:
	printerr("calculate_cost() method not defined")


## Virtual class, must be overwritten.[br]
func is_afordable() -> bool:
	return false

## Virtual class, must be overwritten.[br]
func buy_one() -> void:
	printerr("buy_one() method not defined")
