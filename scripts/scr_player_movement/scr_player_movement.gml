// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_player_movement(player_self){
	var moveX = keyboard_check(vk_right) - keyboard_check(vk_left);
	var moveY = keyboard_check(vk_down) - keyboard_check(vk_up);
	
	if (moveX != 0 && moveY != 0) {
		moveX *= 0.7071
		moveY *= 0.7071
	}
	
	player_self.x += moveX * player_self.PLAYER_SPEED;
	player_self.y += moveY * player_self.PLAYER_SPEED;
}