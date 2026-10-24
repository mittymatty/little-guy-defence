extends Node
enum CLICK_MODE {NONE,SHOOT,PLACE}
var current_click_mode: CLICK_MODE = CLICK_MODE.PLACE
var blocks: int = 10
var stored_troops: Array[PackedScene] = []
var curent_wave: int = 0

var all_possible_troop_data: Array[TroopData] = [
	preload("res://resources/pistol_trooper.tres"),
	preload("res://resources/rifle_trooper.tres"),
	preload("res://resources/shotgun_trooper.tres"),
	preload("res://resources/two_pistol_troopers.tres"),
]
