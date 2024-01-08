// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_camera(camera_self){
	if (camera_self.follow != noone) {
		camera_self.x_to = camera_self.follow.x
		camera_self.y_to = camera_self.follow.y
	}
	
	camera_self.x += (camera_self.x_to - camera_self.x) / camera_self.viscosity
	camera_self.y += (camera_self.y_to - camera_self.y) / camera_self.viscosity
	
	camera_set_view_pos(view_camera[camera_self.camera_num], camera_self.x-(camera_self.cam_width*0.5), camera_self.y-(camera_self.cam_height*0.5))
	
}