// This is for the dialog object to load the text on the screen.
function scr_dialog_load(player){
	if ((currCharIndex < string_length(textDialog[convoIndex, 1]) + 1) && desireFullSentence == false){	
		spriteToDisplay = text[convoIndex, 0];
		stringToDisplay += string_char_at(textDialog[convoIndex, 1], currCharIndex++);
		titleToDisplay = title[convoIndex + 1, 2]; //This works and I don't know why. May be deleted in the future
			if (keyboard_check_pressed(vk_space) && currCharIndex > 2){
				desireFullSentence = true;
				fullSentence = textDialog[convoIndex,1];
			}
	} else {
	
		if (keyboard_check_pressed(vk_space)){ 
			convoIndex++;
			stringToDisplay = "";
			currCharIndex = 1;
			desireFullSentence = false;

			if(convoIndex == convoDialogCount){
				active = false;
				canBeginConvo = false;
				player.CURRENT_PLAYER_STATE = PLAYER_STATE.WALKING
				scr_dialog_init()
				
			}		
		}
	}
}

