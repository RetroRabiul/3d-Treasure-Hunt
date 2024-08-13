extends Control

var score_count = 0
 
var Speed_Time = 30

var Power_time = 30

var time = 0

func _ready():
	GlobalSignal.connect("can_use" , self, "_can_use")
	GlobalSignal.connect("collected_key" , self, "_collected_key")
	GlobalSignal.connect("locked_door" , self, "_locked_door")
	GlobalSignal.connect("climbing" , self, "_climbing")
	GlobalSignal.connect("power_time" , self, "_power_time")
	GlobalSignal.connect("speed" , self, "_speed")
	GlobalSignal.connect("sign_text", self, "_sign_text")
	GlobalSignal.connect("sign_hide", self, "_sign_hide")
	$TimeLable.text = "Time : " + str(time)


func _sign_hide():
	$"%sign_text".visible = false

func _sign_text(text):
	$"%sign_text".text = ""+str(text)
	$"%sign_text".visible = true


func _speed():
	$speed_timer.start()
	$speed_label.text = "Speed_Time : "+str(Speed_Time)


func _process(delta):
	$Jump_Label.text = "J.P.T : "+str(Power_time)
	$speed_label.text = "Speed_Time : "+str(Speed_Time)
	$TimeLable.text = "Time : " + str (time)

func _locked_door():
	$"%sign_text".text = "LOCKED"
	$"%sign_text".visible = true 
	
func _power_time():
	$Jump_Timer.start()
	Power_time -= 1
	$Jump_Label.text = "J.P.T : "+str(Power_time)


func _collected_key(count):
	GlobalVars.key_count += count


func _can_use(state):
	if state:
		$"%sign_text".text = "press e"
		$"%sign_text".visible = true
	else:
		$"%sign_text".visible = false

func _climbing(state):
	if state:
		$"%sign_text".text = "x to climb up / z to climb down"
		$"%sign_text".visible = true
	else:
		$"%sign_text".visible = false



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


func _on_Timer_timeout():
	if GlobalVars.tresure_opened == false:
		time += 1
