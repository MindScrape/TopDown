// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Camera3(_startPosX, _startPosY, _startPosZ) constructor {
	pitch = 0;
	direction = 0;
	x = _startPosX
	y = _startPosY
	z = _startPosZ
	
	apply = function() {
		draw_clear(c_black);
		
		var camera = camera_get_active()
		camera_set_view_mat(camera, matrix_build_lookat(x, y, z, x + dcos(direction) * dcos(pitch), y - dsin(direction) * dcos(pitch), z + dsin(pitch), 0, 0, 1))
		camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(-60, -window_get_width() / window_get_height(), 1, 32000))
		camera_apply(camera)
		
		with (obj_gameObject) event_perform(ev_draw, 0);
	}
	
	// wraps a value around a certain range
	normalize = function(value, modulo) {
		var remainder = (value % modulo);
		return (remainder < 0) ? (modulo + remainder) : remainder;
	}
	
	freeRoam = function() {
		direction = self.normalize(direction - (display_mouse_get_x() - display_get_width() / 2) / 10, 360);
		//show_debug_message("DIRECTION: " + string(direction))
		pitch = clamp(pitch - (display_mouse_get_y() - display_get_height() / 2) / 10, -80, 80);
		//show_debug_message("PITCH: " + string(pitch))
		display_mouse_set(display_get_width() / 2, display_get_height() / 2);

		if (keyboard_check(vk_escape)){
		    game_end();
		}

		if (keyboard_check(ord("A"))){
			x -= dsin(direction) * 4;
			y -= dcos(direction) * 4;
		}

		if (keyboard_check(ord("S"))){
			x -= dcos(direction) * 4;
			y += dsin(direction) * 4;
		}

		if (keyboard_check(ord("D"))){
			x += dsin(direction) * 4;
			y += dcos(direction) * 4;
		}

		if (keyboard_check(ord("W"))){
			x += dcos(direction) * 4;
			y -= dsin(direction) * 4;
		}
		
		if (keyboard_check(vk_shift)){
			z -= 4
		}
		
		if (keyboard_check(vk_space)){
			z += 4
		}
	}
}