// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function scr_init_player_camera_and_view(camera_self){
	// This is for the CAMERA. It is what we project relative to the game world.
	global.Camera = camera_create_view(0,0,camera_self.cam_width,camera_self.cam_height)
	
	camera_set_view_border(global.Camera,camera_self.cam_width,camera_self.cam_height)
	camera_set_view_size(global.Camera,camera_self.cam_width,camera_self.cam_height)
	camera_set_view_target(global.Camera,camera_self)
	
	view_enabled = true
	view_visible[0] = true
	view_set_camera(0,global.Camera)
	
	// This is the VIEWPORT. It is in relation to the user's monitor.
	window_set_size(camera_self.cam_width*camera_self.viewport_scale, camera_self.cam_height*camera_self.viewport_scale);
	surface_resize(application_surface, camera_self.cam_width*camera_self.viewport_scale, camera_self.cam_height*camera_self.viewport_scale)
}