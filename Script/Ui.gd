extends Control

var score_count = 0
 
var Speed_Time = 30

var Power_time = 30

func _ready():
	GlobalSignal.connect("can_use" , self, "_can_use")
	GlobalSignal.connect("collected_key" , self, "_collected_key")
	GlobalSignal.connect("locked_door" , self, "_locked_door")
	GlobalSignal.connect("climbing" , self, "_climbing")
	GlobalSignal.connect("power_time" , self, "_power_time")
	GlobalSignal.connect("speed" , self, "_speed")
	GlobalSignal.connect("sign_text", self, "_sign_text")
	GlobalSignal.connect("sign_hide", self, "_sign_hide")

	


func _sign_hide():
	$sign_text.visible = false

func _sign_text(text):
	$sign_text.text = ""+str(text)
	$sign_text.visible = true



func _speed():
	$speed_timer.start()
	$speed_label.text = "Speed_Time : "+str(Speed_Time)



func _process(delta):
	$Jump_Label.text = "J.P.T : "+str(Power_time)
	$speed_label.text = "Speed_Time : "+str(Speed_Time)

func _locked_door():
	$"%UseLabel".text = "LOCKED"
	$"%UseLabel".visible = true 
	
func _power_time():
	$Jump_Timer.start()
	Power_time -= 1
	$Jump_Label.text = "J.P.T : "+str(Power_time)


func _collected_key(count):
	GlobalVars.key_count += count


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



func _on_Jump_Timer_timeout():
	Power_time -= 1
	if Power_time == 0:
		GlobalSignal.emit_signal("reset_jump")
		$Jump_Timer.stop()


func _on_speed_timer_timeout():
	Speed_Time -= 1
	if Speed_Time == 0:
		$time_end.play()
		$speed_timer.stop()
