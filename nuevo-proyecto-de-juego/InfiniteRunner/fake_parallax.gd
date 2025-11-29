extends Node2D

@export var npc: PackedScene

func _on_npc_spawn_timeout() -> void:
	# SpawnNPC 
	# Choose a random location on Path2D.
	var npc1_location = $Path1/PathFollow2D
	npc1_location.progress_ratio = randf()
	var instanceNPC1 = npc.instantiate()
	instanceNPC1.global_position = npc1_location.global_position
	$"../Background".add_sibling(instanceNPC1)
	await get_tree().create_timer(randf_range(0.2,0.5)).timeout
	var npc2_location = $Path2/PathFollow2D
	npc2_location.progress_ratio = randf()
	var instanceNPC2= npc.instantiate()
	instanceNPC2.global_position = npc2_location.global_position
	$"../Background".add_sibling(instanceNPC2)
	# ResetTimer
	$NPCSpawn.wait_time = randf_range(0.5,1.5)
	$NPCSpawn.start()
