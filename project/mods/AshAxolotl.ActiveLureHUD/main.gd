extends Node

onready var PlayerAPI = get_node_or_null("/root/BlueberryWolfiAPIs/PlayerAPI")
onready var LureRect = preload("res://mods/AshAxolotl.ActiveLureHUD/LureRect.tscn")

var lure_rect = null

func _ready():
	PlayerAPI.connect("_ingame", self, "_ingame")
	PlayerData.connect("_bait_update", self, "_update")

func _ingame():
	var bait_ui = get_node("/root/playerhud/main/in_game/bait")
	bait_ui.rect_position = bait_ui.rect_position - Vector2(bait_ui.rect_size.x * 1.5 - bait_ui.rect_size.x, 0)
	bait_ui.rect_size = Vector2(bait_ui.rect_size.x * 1.5, bait_ui.rect_size.y)
	bait_ui.rect_min_size = Vector2(bait_ui.rect_min_size.x * 1.5, bait_ui.rect_min_size.y)
	lure_rect = LureRect.instance()
	bait_ui.get_child(0).add_child(lure_rect)
	_update()

func _update():
	if lure_rect != null:
		lure_rect.texture = PlayerData.LURE_DATA[PlayerData.lure_selected]["icon"]
