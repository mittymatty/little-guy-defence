extends Node
enum CLICK_MODE {SHOOT,PLACE}
var current_click_mode: CLICK_MODE = CLICK_MODE.PLACE
var blocks: int = 10
var stored_troops: Array[PackedScene] = [preload("uid://c0v6l6r5fiqtr"),preload("uid://c0v6l6r5fiqtr"),preload("uid://dhvuhdfdvg04k")]
