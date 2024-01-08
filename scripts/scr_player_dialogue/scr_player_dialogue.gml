// PLAYER will look for dialogues to converse with if the player ACTIONS for it
// If the PLAYER is within range of a dialog object, then we will get the closest one.
// We will then paralyze the player in a TALKING state. The dialog, once completed, will 
// unparalyze the player and put the player in a different state (WALKING, ETC).
function scr_player_dialogue_init(player_self){
	// Get the nearest dialogue object
	var nearest_dialog_items = __get_nearest_dialog(player_self)
	if nearest_dialog_items == noone or nearest_dialog_items[1] > player_self.DIALOGUE_RANGE {
		return
	}
	// Paralyze the player in a TALKING state
	player_self.CURRENT_PLAYER_STATE = PLAYER_STATE.TALKING
	player_self.DIALOGUE_PLAYER_CAN_TALK = false
	player_self.DIALOGUE_INSTANCE = nearest_dialog_items[0]
	
	// Let the dialog instance know that we can begin the conversation
	player_self.DIALOGUE_INSTANCE.canBeginConvo = true
	player_self.DIALOGUE_INSTANCE.player = player_self
	
	// ... the player is now going through the convo ...
}


// Returns a list. [0] The closest dialog object. [1] The distance to the dialog object
function __get_nearest_dialog(obj_self) {
	var closest_npc = noone
	var closest_npc_distance = -1
	for (var i = 0; i < instance_number(obj_dialog); i++) {
		var npc = instance_find(obj_dialog, i)
		var distance = point_distance(obj_self.x,obj_self.y,npc.x,npc.y)
	
		if closest_npc_distance == -1 {
			closest_npc = npc
			closest_npc_distance = distance
			continue
		}
	
		if distance < closest_npc_distance {
			closest_npc = npc 
			closest_npc_distance = distance
			continue
		}
	}
	
	if closest_npc == noone {
		return noone
	} else {
		var closest_npc_array = array_create(2)
		closest_npc_array[0] = closest_npc
		closest_npc_array[1] = closest_npc_distance
		return closest_npc_array
	}
}
