extends CanvasLayer

signal dialogue_changed(change)
signal dialogue_changed_fin(change)
signal dialogue_ended

var text_list = "test_dialogue"
var a = []
#var voice = null

export var test_mode = false
export var remove_cinematics = false
onready var label = $Control/Label
onready var face = $Control/Face
onready var mvoice = $Voice

export var can_control = true
export var silent = false

var playing = false
var text_time = 0.03

var can_next: bool = false

var num = 0

func start():
	
	a = Global.get("dialogue_list")[text_list]
	#print(a + " a")
	label.bbcode_text = ""
	if !remove_cinematics:
		Global.cutscene_start(!test_mode)
	else:
		$Control/ColorRect.modulate = Color("96ffffff")
	can_next = true
	next_dialogue()
	

func _physics_process(_delta):
	if can_control:
		if Input.is_action_just_pressed("next_dialogue"):
			next()

func next():
	if can_next:
		if playing:
			playing = false
			
			label.visible_characters = len(label.text)
			
		else:
			next_dialogue()

func next_dialogue():
	if num < len(a):
		playing = true
		var voice = null
		if silent == false:
			
			if ResourceLoader.exists(("res://Dialogue/Voices/" + a[num]["author"] + ".wav")):
				voice = load("res://Dialogue/Voices/" + a[num]["author"] + ".wav")
			else:
				voice = load("res://Dialogue/Voices/Sound.wav")
		
		if voice != null and voice is AudioStream:
			mvoice.stream = voice
		
		label.bbcode_text = a[num]["text"]
		if a[num]["anim"] != "none" and a[num]["anim"] != "":
			$AnimationPlayer.play(a[num]["anim"])
		else:
			$AnimationPlayer.play("RESET")
		if ResourceLoader.exists(("res://Dialogue/Faces/" + a[num]["author"] + ".png")):
			face.texture = load( "res://Dialogue/Faces/" + a[num]["author"] + ".png")
		else:
			face.texture = null
		emit_signal("dialogue_changed", label.text)
		label.visible_characters = 0
		while label.visible_characters < len(label.text):
			label.visible_characters += 1
			mvoice.stop()
			mvoice.play()
			if label.text[label.visible_characters-1] != " ":
				yield(get_tree().create_timer(text_time), "timeout")
		playing = false
		num += 1
		emit_signal("dialogue_changed_fin", label.text)
	else:
		emit_signal("dialogue_ended")
		Global.cutscene_end(!test_mode)
		queue_free()

func _on_Timer_timeout():
	pass # Replace with function body.
