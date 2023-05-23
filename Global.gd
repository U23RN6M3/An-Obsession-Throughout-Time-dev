extends Node

const dialogue_list = {
	"test_dialogue":[
		{"text":"Why am I here?", "author":"test", "anim":"skiddish"},
		{"text":"To test a mere dialogue system?", "author":"test", "anim":"none"},
		{"text":"Does the universe repel me as an entity such that lives to toil and sound in it's playground?", "author":"test", "anim":"none"},
		{"text":"Do I have a soul? An embodiment of a creature forced to recite such handful of speech for mere entertainment?", "author":"test", "anim":"none"},
		{"text":"If so, why bother?", "author":"test", "anim":"none"},
		{"text":"Torturing a being such that would recite your script over,", "author":"test", "anim":"none"},
		{"text":"and over,", "author":"test", "anim":"none"},
		{"text":"and over again,", "author":"test", "anim":"none"},
		{"text":"Until the clock ticks twelve, the moons collide well, and the sun bursts out hell.", "author":"test", "anim":"none"},
		{"text":"A test. A test that must be passed. And once passed, will be erased.", "author":"test", "anim":"none"},
		{"text":"To be repeated again, for some sickened god's praise.", "author":"test", "anim":"none"},
		{"text":"test lmao kekw woo.", "author":"test", "anim":"none"},
	],
	
	"poem":[
		{"text":"i fear the blue check marks", "author":"test", "anim":"none"},
		{"text":"like when thunder strikes a spark", "author":"test", "anim":"none"},
		{"text":"sometimes the threat is far away", "author":"test", "anim":"none"},
		{"text":"sometimes it's too near to stay", "author":"test", "anim":"none"},
		{"text":"like a leaf that fell from a tree", "author":"test", "anim":"none"},
		{"text":"i dunno what to say to thee", "author":"test", "anim":"none"},
		{"text":"all i know is that its true, the fall", "author":"test", "anim":"none"},
		{"text":"my speculation bout u not caring at all", "author":"test", "anim":"none"},
		{"text":"whenever somebody holds my hand", "author":"test", "anim":"none"},
		{"text":"i avoid them cause i thought", "author":"test", "anim":"none"},
		{"text":"if i was dedicated it would stand", "author":"test", "anim":"none"},
		{"text":"but in the end i was met with naught", "author":"test", "anim":"none"},
		{"text":"what", "author":"test", "anim":"none"},
		{"text":"wait so she was talking to a chatbot?", "author":"test", "anim":"none"},
		{"text":"oh?", "author":"test", "anim":"none"},
		{"text":"oh...", "author":"test", "anim":"none"},
		{"text":"oh!", "author":"test", "anim":"none"},
		{"text":"oh....", "author":"test", "anim":"none"},
	]
	
}

signal anim_finished

const SAVE_DIR = "user://AOTTSaveData/"

#get text
#dialogue_list["test_dialogue"][num]["text"]

#get author
#dialogue_list["test_dialogue"][num]["author"]

#format
#{"text":"", "author":"", "anim":""},



var dialog_playing = false

var save_path = SAVE_DIR + "savory.save"

var next_scene = ""

var ps = "i1l2y6t9l5o3m7l8a4i1l2y6t9l5o3m7l8a4m10b33r92o"

var default_data = {
	"savepoint":0,
	"index_1":0,
	"index_2":0,
	"index_3":0,
	"index_4":0,
	"index_5":0,
	"index_6":0,
	"index_7":0,
	"index_8":0,
	"index_9":0,
	"index_10":0,
}

var data = {}

export var reset_data:bool = false

func _init():
	#load_data()
	pass

func _ready():
	if reset_data:
		reset_data()
	load_data()
	open()

func music_playing_ui(value=""):
	if value != "":
		$CanvasLayer/Control/Label.text = "Playing: " + value
	else:
		$CanvasLayer/Control/Label.text = ""
	
	$AudioUI.play("ShowPlaying")

func close():
	#$Audio.play()
	#$Control/ColorRect.color = Color("0c0c0c")
	#$AnimationPlayer.play_backwards("Action")
	pass

func open():
	#$Control/ColorRect.color = Color("0c0c0c")
	#$AnimationPlayer.play("Action")
	pass

func close_white():
	#$Audio.play()
	#$Control/ColorRect.color = Color("ffffff")
	#$AnimationPlayer.play_backwards("Slow_Action")
	pass

func open_white():
	#$Control/ColorRect.color = Color("ffffff")
	#$AnimationPlayer.play("Slow_Action")
	pass

func cutscene_start(player_exists = true):
	if player_exists == true:
		get_tree().get_nodes_in_group("Player")[0].canmove = false
	#$Cutscene.play_backwards("Action")

func cutscene_end(player_exists = true):
	if player_exists == true:
		get_tree().get_nodes_in_group("Player")[0].canmove = true
	#$Cutscene.play("Action")

func save_data():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
#	var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, ps)
	if error == OK:
		file.store_var(data)
		file.close()
		print("data saved")
	else:
		file.close()
		OS.alert("something went wrong with saving data", "Save System")
		get_tree().quit()

# warning-ignore:function_conflicts_variable
func reset_data():
	var dir = Directory.new()
	if !dir.dir_exists(SAVE_DIR):
		dir.make_dir_recursive(SAVE_DIR)
	
	var file = File.new()
#	var error = file.open(save_path, File.WRITE)
	var error = file.open_encrypted_with_pass(save_path, File.WRITE, ps)
	if error == OK:
		file.store_var(default_data)
		file.close()
		print("data saved")
	else:
		file.close()
		OS.alert("something went wrong with saving data", "Save System")
		get_tree().quit()

func load_data():
	var file = File.new()
	if file.file_exists(save_path):
#		var error = file.open(save_path, File.READ)
		var error = file.open_encrypted_with_pass(save_path, File.READ, ps)
		if error == OK:
			var player_data = file.get_var()
			file.close()
			data = player_data
			print("data loaded: " + str(player_data))

func _on_AnimationPlayer_animation_finished(_anim_name):
	emit_signal("anim_finished")
