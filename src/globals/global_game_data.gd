extends Node

# Array of the players loaded from json file
var player_data: Array = []

const player_scene = preload("res://src/players/player.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	load_players()


class MyCustomSorter:
	static func sort_ascending_by_rank(a, b):
		if a.rank < b.rank:
			return true
		return false


func load_players():
	var paths = GlobalUtils.get_filepaths_in_directory("res://src/players/resources/", ".tres")

	for p in paths:
		player_data.append(load(p))
	print(paths)
	player_data.sort_custom(Callable(MyCustomSorter, "sort_ascending_by_rank"))


func create_player(player_data, ai_controlled: bool):
	var player = player_scene.instantiate()
	player.setup(player_data, ai_controlled)
	return player


func get_player_data_by_index(index: int) -> PlayerData:
	return player_data[index]
