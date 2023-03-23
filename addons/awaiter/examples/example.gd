extends Node

func _ready():
	var t1_finished = get_tree().create_timer(1.0).timeout
	var t2_finished = get_tree().create_timer(2.0).timeout
	
	await Awaiter.wait_for([t1_finished, t2_finished])
	
	print('All Finished!')
	
	t1_finished = get_tree().create_timer(1.0).timeout
	t2_finished = get_tree().create_timer(2.0).timeout
	t2_finished.connect(func(): print("T2 Finished!"))
	
	await FirstAwaiter.wait_for([t1_finished, t2_finished])
	
	print('First Finished!')
	
	var t1 = Timer.new()
	t1.wait_time = 2.0
	t1.autostart = true
	
	var t2 = Timer.new()
	t2.wait_time = 1.0
	t2.autostart = true
	t2.timeout.connect(t1.queue_free)
	
	add_child(t1)
	add_child(t2)
	
	await FirstAwaiter.wait_for([t1.tree_exiting, t1.timeout])
	
	print("Did not wait forever!")
