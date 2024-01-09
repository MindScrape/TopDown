// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Shape() constructor {
	
	static initializeGpu = true

	static initGpu = function() {
		if initializeGpu {
			gpu_set_ztestenable(true)
			gpu_set_zwriteenable(true)
			initializeGpu = false
		}
	}
	
	initVFormat = function() {
		vertex_format_begin()
		vertex_format_add_position_3d()
		vertex_format_add_normal()
		vertex_format_add_texcoord()
		vertex_format_add_color()
		return vertex_format_end()
	}
	
	initVBuffer = function() {
		var vFormat = initVFormat()
		var vBuffer = vertex_create_buffer()
		vertex_begin(vBuffer, vFormat)
		return vBuffer
	}
	
	vertexAddPoint = function(vBuffer, posX, posY, posZ, normX, normY, normZ, texU, texV, color, alpha) {
		vertex_position_3d(vBuffer, posX, posY, posZ)
		vertex_normal(vBuffer, normX, normY, normZ)
		vertex_texcoord(vBuffer, texU, texV)
		vertex_color(vBuffer, color, alpha)
	}
}