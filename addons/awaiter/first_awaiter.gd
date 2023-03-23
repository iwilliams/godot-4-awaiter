class_name FirstAwaiter 
extends Awaiter


static func wait_for(signals: Array[Signal]) -> Signal:
	return new(signals).finished


func _is_finished():
	var done = (total == 0 or total_done >= 1)
	return done

