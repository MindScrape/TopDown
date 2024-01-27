// Some helpful functions for drawing stuff to the screen.
function Shape() constructor {
	
	static hasInitializedGpu = false

	static initGpu = function() {
		if hasInitializedGpu {
			show_message("Shape() only needs to initialize the GPU once. Doing this more than once is a bug and unnecessary.")
		}
		gpu_set_ztestenable(true)
		gpu_set_zwriteenable(true)
		gpu_set_cullmode(cull_clockwise)
		//gpu_set_fog(true, c_black, 200, 300);
		hasInitializedGpu = true
	}
	
	static initVFormat = function() {
		vertex_format_begin()
		vertex_format_add_position_3d()
		vertex_format_add_normal()
		vertex_format_add_texcoord()
		vertex_format_add_color()
		return vertex_format_end()
	}
	
	static initVBuffer = function() {
		var vFormat = initVFormat()
		var vBuffer = vertex_create_buffer()
		vertex_begin(vBuffer, vFormat)
		return vBuffer
	}
	
	static vertexAddPoint = function(vBuffer, posX, posY, posZ, normX, normY, normZ, texU, texV, color, alpha) {
		vertex_position_3d(vBuffer, posX, posY, posZ)
		vertex_normal(vBuffer, normX, normY, normZ)
		vertex_texcoord(vBuffer, texU, texV)
		vertex_color(vBuffer, color, alpha)
	}
}