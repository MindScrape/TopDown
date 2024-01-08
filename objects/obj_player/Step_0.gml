/// @description The step code for the player

if CURRENT_PLAYER_STATE == PLAYER_STATE.WALKING {
	scr_player_movement(self)
	
	// Dialogue logic
	if (DIALOGUE_PLAYER_CAN_TALK and keyboard_check_pressed(vk_space)) {
		scr_player_dialogue_init(self)
	} else if DIALOGUE_PLAYER_CAN_TALK == false and keyboard_check_released(vk_space) {
		DIALOGUE_PLAYER_CAN_TALK = true
	}
}

