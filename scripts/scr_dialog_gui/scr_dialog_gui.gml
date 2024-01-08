// Have this drawing when the player is talking
function scr_dialog_gui(){
	if (!active) {
		return
	}
	
	//Set font here
	// draw_set_font(fnt_Dialog);

	//Draw boxes
	draw_set_color(c_white);
	draw_rectangle(xOrigin, yOrigin, xOrigin + width, yOrigin + height, false);

	draw_set_color(c_black);
	draw_rectangle(innerBox_xOrigin, innerBox_yOrigin, innerBox_xOrigin + innerBoxWidth, innerBox_yOrigin + innerBoxHeight, false);

	//Draw text
	yTitleSpace = 35;
	if (desireFullSentence == false){
		draw_set_color(c_white);
		draw_text(text_xOrigin + 25, text_yOrigin - yTitleSpace, titleToDisplay); //titleToDisplay may be deleted in the future
		draw_text(text_xOrigin, text_yOrigin + 5, "*"); //Draw star
		draw_text_ext(text_xOrigin + 25, text_yOrigin + 5, stringToDisplay, 30, 900); //draw text
		draw_sprite_ext(spriteToDisplay, -1, avatar_xOrigin, avatar_yOrigin, avatarScale, avatarScale, 0, c_white, 1); //draw Sprite
	}
	if (desireFullSentence == true){
		draw_set_color(c_white);
		draw_text(text_xOrigin + 25, text_yOrigin - yTitleSpace, titleToDisplay); //titleToDisplay may be deleted in the future
		draw_text(text_xOrigin, text_yOrigin + 5, "*"); //Draw star
		draw_text_ext(text_xOrigin + 25, text_yOrigin + 5, fullSentence, 30, 900); //draw text ONLY DIFF
		draw_sprite_ext(spriteToDisplay, -1, avatar_xOrigin, avatar_yOrigin, avatarScale, avatarScale, 0, c_white, 1); //draw Sprite
	}
}