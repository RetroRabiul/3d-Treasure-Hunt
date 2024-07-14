extends Control

var score_count = 0

var Power_time = 30

func _ready():
	GlobalSignal.connect("change_score" , self, "_change_score")
	GlobalSignal.connect("can_use" , self, "_can_use")
	GlobalSignal.connect("collected_key" , self, "_collected_key")
	GlobalSignal.connect("locked_door" , self, "_locked_door")
	GlobalSignal.connect("climbing" , self, "_climbing")
	GlobalSignal.connect("power_time" , self, "_power_time")
	$KeyLabel.text = "Keys: "+str(GlobalVars.key_count)
	


func _process(delta):
	$Jump_Label.text = "J.P.T : "+str(Power_time)

func _locked_door():
	$"%UseLabel".text = "LOCKED"
	$"%UseLabel".visible = true 
	
func _power_time():
	$Jump_Timer.start()
	Power_time -= 1
	$Jump_Label.text = "J.P.T : "+str(Power_time)


func _collected_key(count):
	GlobalVars.key_count += count
	$KeyLabel.text = "Key : "+str(GlobalVars.key_count)


func _can_use(state):
	if state:
		$"%UseLabel".text = "press e"
		$"%UseLabel".visible = true
	else:
		$"%UseLabel".visible = false

func _climbing(state):
	if state:
		$"%UseLabel".text = "x to climb up / z to climb up"
		$"%UseLabel".visible = true
	else:
		$"%UseLabel".visible = false




func _change_score():
	score_count =+ 1
	$ScoreLable.text = "Score :" +str(score_count)




func _on_Jump_Timer_timeout():
	Power_time -= 1
	if Power_time == 0:
		GlobalSignal.emit_signal("reset_jump")
		$Jump_Timer.stop()
