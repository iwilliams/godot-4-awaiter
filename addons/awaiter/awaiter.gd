class_name Awaiter 
extends Object

signal finished

var total = 0
var total_done = 0

static func wait_for(signals: Array[Signal]) -> Signal:
	return new(signals).finished

func _init(signals: Array[Signal]):
	total = signals.size()
	for sig in signals:
		await_signal(sig)
		
func await_signal(sig: Signal):
	await sig
	total_done += 1
	if _is_finished():
		finished.emit()
		call_deferred('free')
	
func _is_finished():
	return total_done >= total
