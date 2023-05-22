extends Node

signal dialogue_changed(change)
signal dialogue_changed_fin(change)
signal dialogue_ended(i)

export var queue = [
	{
		"activated":true,
		"source":"test_dialogue_2",
		"test_mode":false,
		"remove_cinematics":false,
		"can_control":true,
		"silent":false,
	},
	{
		"activated":false,
		"source":"test_dialogue_2",
		"test_mode":false,
		"remove_cinematics":false,
		"can_control":true,
		"silent":false,
	},
	{
		"activated":false,
		"source":"test_dialogue_2",
		"test_mode":false,
		"remove_cinematics":false,
		"can_control":true,
		"silent":false,
	},
	{
		"activated":false,
		"source":"test_dialogue_2",
		"test_mode":false,
		"remove_cinematics":false,
		"can_control":true,
		"silent":false,
	},
	{
		"activated":false,
		"source":"test_dialogue_2",
		"test_mode":false,
		"remove_cinematics":false,
		"can_control":true,
		"silent":false,
	},
]

func create_dialogue(index):
	var instance = load("res://Dialogue/Dialogue.tscn").instance()
	instance.text_list = index["source"]
	instance.test_mode = index["test_mode"]
	instance.remove_cinematics = index["remove_cinematics"]
	instance.can_control = index["can_control"]
	instance.silent = index["silent"]
	get_tree().get_nodes_in_group("Main")[0].call("add_child", instance)
	instance.start()
	return instance

func buffer(nindex):
	yield(get_tree().create_timer(0.5), "timeout")
	start_sequence(nindex)

func start_sequence(index):
	var instance = create_dialogue(queue[index])
	#for i in ["dialogue_changed", "dialogue_changed_fin", "dialogue_ended"]:
		#instance.connect(i, self, "emit_signal", [i])
	if queue[index+1]["activated"]:
		instance.connect("dialogue_ended", self, "buffer", [index+1])
	
