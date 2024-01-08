// This is for adding conversations.
function scr_convo_addLine(arg_sprite, arg_title, arg_text){
	text[convoDialogCount, 0] = arg_sprite
	title[convoDialogCount, 2] = arg_title
	textDialog[convoDialogCount++, 1] = arg_text
}

// These values need to always be reset.
function scr_convo_begin() {
	dialogNum = 0 //useless?
	convoIndex = 0
}