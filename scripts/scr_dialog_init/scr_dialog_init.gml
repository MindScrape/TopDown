// This will initialize the dialogue object
function scr_dialog_init(){
	padding = 50; //Padding on x axis between box and window.

	//Outerbox Properties
	width = window_get_width() - (padding * 2);
	height = 200;
	xOrigin = padding;
	yOrigin = 590; //changed this may be change later ORIGINAL: yOrigin = 10;

	//Innerbox Properties
	borderSize = 20;
	innerBoxWidth = width - borderSize;
	innerBoxHeight = height - borderSize;
	innerBox_xOrigin = xOrigin + (borderSize / 2);
	innerBox_yOrigin = yOrigin + (borderSize / 2);

	//Dialog display properties
	avatarScale = 2;
	avatar_xOrigin = innerBox_xOrigin + 15;
	avatar_yOrigin = innerBox_yOrigin + 20;

	text_xOrigin = avatar_xOrigin + 150;
	text_yOrigin = avatar_yOrigin + 25;

	for (i = 0; i < 100; i++){ 
			text[i , 0] = -1		 //Sprite Index
			textDialog[i , 1] = ""	 //Convo Dialog
			title[i , 2] = "";		 //Title Maybe delete this in the future.

	}
	
	canBeginConvo = false;		// The player can begin a conversation if the player chooses the dialog
	active = false;					// Whether or not this conversation is ongoing...
	
	convoDialogCount = 0;			// Number of lines in a specific convo
	convoIndex = 0;					// Current index towards our convo dialog count
	spriteToDisplay = spr_noone;	// Avatar to display
	stringToDisplay = "";			// Dialogue of the convo to display
	titleToDisplay = "";			// Title of the convo to display
	currCharIndex = 1;				// Current character index of string to apply to stringToDisplay
	
	player = noone					// The player conversing with the dialogue.

	fullSentence = "";
	desireFullSentence = false;
}
