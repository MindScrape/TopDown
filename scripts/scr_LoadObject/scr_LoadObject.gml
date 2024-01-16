// Loads a .obj wavefront model into the world

// This is really ugly code right now, but it gets the job done
function LoadObject() : Shape() constructor {

	// This is incredibly inefficient if we want to cull edges...
	// Step #1: We need to hard code drawing the blocks (?)
	// Step #2: We need to implement block face culling....
	static loadBlock = function(uvBlockTextureItem) {
		
		var filename = uvBlockTextureItem.blockType + ".obj"
		var mtlname = uvBlockTextureItem.blockType + ".mtl"
		var uOffset = uvBlockTextureItem.uOffset
		var vOffset = uvBlockTextureItem.vOffset
		
		var obj_file = file_text_open_read(filename); 
		var mtl_file = file_text_open_read(mtlname);

		var mtl_name = "None";
		var active_mtl = "None";

		// Create ds_maps to link the color/alpha/other attributes to the material name

		var mtl_alpha = ds_map_create();
		var mtl_color = ds_map_create();

		// Set the default attributes

		ds_map_add(mtl_alpha, "None", 1);
		ds_map_add(mtl_color, "None", c_white);

		// For each line in the mtl file

		while(not file_text_eof(mtl_file)){
			var line = file_text_read_string(mtl_file);
			file_text_readln(mtl_file);
			// Split each line around the space character
			var terms, index;
			index = 0;
			terms[0] = "";
			terms[string_count(line, " ")] = "";
			for (var i = 1; i <= string_length(line); i++){
				if (string_char_at(line, i) == " "){
					index++;
					terms[index] = "";
				} else {
					terms[index] = terms[index]+string_char_at(line, i);
				}
			}
			switch(terms[0]){
				case "newmtl":
					// Set the material name
					mtl_name = terms[1];
					break;
				case "Kd":
					// Diffuse color (the color we're concerned with)
					var red = real(terms[1])*255;
					var green = real(terms[2])*255;
					var blue = real(terms[3])*255;
					var color = make_color_rgb(red, green, blue);
					ds_map_set(mtl_color, mtl_name, color);
					break;
				case "d":
					// "dissolved" (alpha)
					var alpha = real(terms[1]);
					ds_map_set(mtl_alpha, mtl_name, alpha);
					break;
				default:
					// There are way more available attributes in mtl files, but we're only concerned with these three (two)
					break;
			}
		}

		// Create the lists of position/normal/texture data
		var vertex_x = ds_list_create();
		var vertex_y = ds_list_create();
		var vertex_z = ds_list_create();

		var vertex_nx = ds_list_create();
		var vertex_ny = ds_list_create();
		var vertex_nz = ds_list_create();

		var vertex_xtex = ds_list_create();
		var vertex_ytex = ds_list_create();
		
		// There are 12 triangles in a cube. Each triangle has 3 points. We should expect this to be 36 points long.
		// 1. TOP	(2 triangles with 3 points each, so 6 vertices in total)
		// 2. BOTTOM
		// 3. A
		// 4. B
		// 5. C 
		// 6. D
		var face_list = ds_list_create()

		// Read each line in the file
		while(not file_text_eof(obj_file)){
			var line = file_text_read_string(obj_file);
			file_text_readln(obj_file);
			// Split each line around the space character
			var terms, index;
			index = 0;
			terms = array_create(string_count(line, " ") + 1, "");
			for (var i = 1; i <= string_length(line); i++){
				if (string_char_at(line, i) == " "){
					index++;
					terms[index] = "";
				} else {
					terms[index] += string_char_at(line, i);
				}
			}
			switch(terms[0]){
				// Add the vertex x, y an z position to their respective lists
				case "v":
					ds_list_add(vertex_x, real(terms[1]));
					ds_list_add(vertex_y, real(terms[2]));
					ds_list_add(vertex_z, real(terms[3]));
					break;
				// Add the vertex x and y texture position (or "u" and "v") to their respective lists
				case "vt":
					ds_list_add(vertex_xtex, real(terms[1]) + uOffset);
					ds_list_add(vertex_ytex, real(terms[2]) - vOffset);
					break;
				// Add the vertex normal's x, y and z components to their respective lists
				case "vn":
					ds_list_add(vertex_nx, real(terms[1]));
					ds_list_add(vertex_ny, real(terms[2]));
					ds_list_add(vertex_nz, real(terms[3]));
					break;
				case "f":
					// Split each term around the slash character
					for (var n = 1; n <= 3; n++){
						var data, index;
						index = 0;
						data = array_create(string_count(terms[n], "/") + 1, "");
						for (var i = 1; i <= string_length(terms[n]); i++){
							if (string_char_at(terms[n], i) == "/"){
								index++;
								data[index] = "";
							} else {
								data[index] += string_char_at(terms[n], i);
							}
						}
						// Look up the x, y, z, normal x, y, z and texture x, y in the already-created lists
						var _xx = ds_list_find_value(vertex_x, real(data[0]) - 1);
						var _yy = ds_list_find_value(vertex_y, real(data[0]) - 1);
						var _zz = ds_list_find_value(vertex_z, real(data[0]) - 1);
						var _xtex = ds_list_find_value(vertex_xtex, real(data[1]) - 1);
						var _ytex = ds_list_find_value(vertex_ytex, real(data[1]) - 1);
						var _nx = ds_list_find_value(vertex_nx, real(data[2]) - 1);
						var _ny = ds_list_find_value(vertex_ny, real(data[2]) - 1);
						var _nz = ds_list_find_value(vertex_nz, real(data[2]) - 1);
				
						// If the material exists in the materials map(s), set the vertex's color and alpha
						// (and other attributes, if you want to use them) based on the material

						var _color = c_white;
						var _alpha = 1;
						if (ds_map_exists(mtl_color, active_mtl)){
							_color = ds_map_find_value(mtl_color, active_mtl);
						}
						if (ds_map_exists(mtl_alpha, active_mtl)){
							_alpha = ds_map_find_value(mtl_alpha, active_mtl);
						}
				
						// Optional: swap the y and z positions (useful if you used the default Blender export settings)
						var t = _yy;
						_yy = _zz;
						_zz = t;
						
						// Store the values of our block so that we can create all permutations of it.
						ds_list_add(face_list, {
							xx : _xx,
							yy : _yy,
							zz : _zz,
							nx : _nx,
							ny : _ny,
							nz : _nz,
							color : _color,
							alpha : _alpha,
							xtex : _xtex,
							ytex : _ytex
						})
					}
					break;
				case "usemtl":
					active_mtl = terms[1];
					break;
				default:
					// There are a few other things you can find in an obj file that I haven't covered here (but may in the future)
					break;
			}
		}
		
		// We need to generate all possible different block variations...
		if ds_list_size(face_list) != 36 {
			show_debug_message("FATAL ERROR: Tried to initialize a block that had more or less than 12 triangles (6 faces / 36 vertices).\nCheck the obj model for typos, or debug loadBlock. Ending Game.")
			game_end()
		}
		var shape = new Shape()
		var format = shape.initVFormat()
		var blockFormats = new Array1(64)
		var blockFaces = [
			0b100000,	// posZ (TOP)
			0b010000,	// negZ (BOTTOM)
			0b001000,	// posX (A)
			0b000100,	// negY (B)
			0b000010,	// negX (C)
			0b000001,	// posY (D)
		]
		for (var i = 0b1; i < blockFormats.size; i++) {
			
			// Create the vertex buffer
			var model = vertex_create_buffer();
			vertex_begin(model, format);
			
			for (var j = 0; j < array_length(blockFaces); j++) {
				var blockFace = i & blockFaces[j]
				var vertexIndex = -1
				switch (blockFace) {
					case 0b100000: // TOP
						vertexIndex = 0
						break
					case 0b010000: // BOTTOM
						vertexIndex = 6
						break
					case 0b001000: // A
						vertexIndex = 12
						break
					case 0b000100: // B
						vertexIndex = 18
						break
					case 0b000010: // C
						vertexIndex = 24
						break
					case 0b000001: // D
						vertexIndex = 30
						break
					default:
						// Intentionally don't do anything if the face doesn't exist.
						continue
				}
				for (var k = 0; k < 6; k++) {
					var p = ds_list_find_value(face_list, vertexIndex + k)
					shape.vertexAddPoint(model, p.xx, p.yy, p.zz, p.nx, p.ny, p.nz, p.xtex, p.ytex, p.color, p.alpha)
				}
			}
			
			// End the vertex buffer
			vertex_end(model);
			vertex_freeze(model)
			blockFormats.set(i, model)
		}

		// Destroy the lists, close the text file and return the vertex buffer

		ds_list_destroy(vertex_x);
		ds_list_destroy(vertex_y);
		ds_list_destroy(vertex_z);
		ds_list_destroy(vertex_nx);
		ds_list_destroy(vertex_ny);
		ds_list_destroy(vertex_nz);
		ds_list_destroy(vertex_xtex);
		ds_list_destroy(vertex_ytex);
		ds_list_destroy(face_list);

		ds_map_destroy(mtl_alpha);
		ds_map_destroy(mtl_color);

		file_text_close(obj_file);
		file_text_close(mtl_file);

		return blockFormats;
	}


	static loadObjFile = function(filename, mtlname) {

		var obj_file = file_text_open_read(filename);
		var mtl_file = file_text_open_read(mtlname);

		var mtl_name = "None";
		var active_mtl = "None";

		// Create ds_maps to link the color/alpha/other attributes to the material name

		var mtl_alpha = ds_map_create();
		var mtl_color = ds_map_create();

		// Set the default attributes

		ds_map_add(mtl_alpha, "None", 1);
		ds_map_add(mtl_color, "None", c_white);

		// For each line in the mtl file

		while(not file_text_eof(mtl_file)){
			var line = file_text_read_string(mtl_file);
			file_text_readln(mtl_file);
			// Split each line around the space character
			var terms, index;
			index = 0;
			terms[0] = "";
			terms[string_count(line, " ")] = "";
			for (var i = 1; i <= string_length(line); i++){
				if (string_char_at(line, i) == " "){
					index++;
					terms[index] = "";
				} else {
					terms[index] = terms[index]+string_char_at(line, i);
				}
			}
			switch(terms[0]){
				case "newmtl":
					// Set the material name
					mtl_name = terms[1];
					break;
				case "Kd":
					// Diffuse color (the color we're concerned with)
					var red = real(terms[1])*255;
					var green = real(terms[2])*255;
					var blue = real(terms[3])*255;
					var color = make_color_rgb(red, green, blue);
					ds_map_set(mtl_color, mtl_name, color);
					break;
				case "d":
					// "dissolved" (alpha)
					var alpha = real(terms[1]);
					ds_map_set(mtl_alpha, mtl_name, alpha);
					break;
				default:
					// There are way more available attributes in mtl files, but we're only concerned with these three (two)
					break;
			}
		}

		// Create the vertex buffer
		var model = vertex_create_buffer();
		vertex_begin(model, new Shape().initVFormat());

		// Create the lists of position/normal/texture data
		var vertex_x = ds_list_create();
		var vertex_y = ds_list_create();
		var vertex_z = ds_list_create();

		var vertex_nx = ds_list_create();
		var vertex_ny = ds_list_create();
		var vertex_nz = ds_list_create();

		var vertex_xtex = ds_list_create();
		var vertex_ytex = ds_list_create();

		// Read each line in the file
		while(not file_text_eof(obj_file)){
			var line = file_text_read_string(obj_file);
			file_text_readln(obj_file);
			// Split each line around the space character
			var terms, index;
			index = 0;
			terms = array_create(string_count(line, " ") + 1, "");
			for (var i = 1; i <= string_length(line); i++){
				if (string_char_at(line, i) == " "){
					index++;
					terms[index] = "";
				} else {
					terms[index] += string_char_at(line, i);
				}
			}
			switch(terms[0]){
				// Add the vertex x, y an z position to their respective lists
				case "v":
					ds_list_add(vertex_x, real(terms[1]));
					ds_list_add(vertex_y, real(terms[2]));
					ds_list_add(vertex_z, real(terms[3]));
					break;
				// Add the vertex x and y texture position (or "u" and "v") to their respective lists
				case "vt":
					ds_list_add(vertex_xtex, real(terms[1]));
					ds_list_add(vertex_ytex, real(terms[2]));
					break;
				// Add the vertex normal's x, y and z components to their respective lists
				case "vn":
					ds_list_add(vertex_nx, real(terms[1]));
					ds_list_add(vertex_ny, real(terms[2]));
					ds_list_add(vertex_nz, real(terms[3]));
					break;
				case "f":
					// Split each term around the slash character
					for (var n = 1; n <= 3; n++){
						var data, index;
						index = 0;
						data = array_create(string_count(terms[n], "/") + 1, "");
						for (var i = 1; i <= string_length(terms[n]); i++){
							if (string_char_at(terms[n], i) == "/"){
								index++;
								data[index] = "";
							} else {
								data[index] += string_char_at(terms[n], i);
							}
						}
						// Look up the x, y, z, normal x, y, z and texture x, y in the already-created lists
						var xx = ds_list_find_value(vertex_x, real(data[0]) - 1);
						var yy = ds_list_find_value(vertex_y, real(data[0]) - 1);
						var zz = ds_list_find_value(vertex_z, real(data[0]) - 1);
						var xtex = ds_list_find_value(vertex_xtex, real(data[1]) - 1);
						var ytex = ds_list_find_value(vertex_ytex, real(data[1]) - 1);
						var nx = ds_list_find_value(vertex_nx, real(data[2]) - 1);
						var ny = ds_list_find_value(vertex_ny, real(data[2]) - 1);
						var nz = ds_list_find_value(vertex_nz, real(data[2]) - 1);
				
						// If the material exists in the materials map(s), set the vertex's color and alpha
						// (and other attributes, if you want to use them) based on the material

						var color = c_white;
						var alpha = 1;
						if (ds_map_exists(mtl_color, active_mtl)){
							color = ds_map_find_value(mtl_color, active_mtl);
						}
						if (ds_map_exists(mtl_alpha, active_mtl)){
							alpha = ds_map_find_value(mtl_alpha, active_mtl);
						}
				
						// Optional: swap the y and z positions (useful if you used the default Blender export settings)
						var t = yy;
						yy = zz;
						zz = t;
				
						// Add the data to the vertex buffers
						vertex_position_3d(model, xx, yy, zz);
						vertex_normal(model, nx, ny, nz);
						vertex_color(model, color, alpha);
						vertex_texcoord(model, xtex, ytex);
					}
					break;
				case "usemtl":
					active_mtl = terms[1];
					break;
				default:
					// There are a few other things you can find in an obj file that I haven't covered here (but may in the future)
					break;
			}
		}

		// End the vertex buffer, destroy the lists, close the text file and return the vertex buffer

		vertex_end(model);

		ds_list_destroy(vertex_x);
		ds_list_destroy(vertex_y);
		ds_list_destroy(vertex_z);
		ds_list_destroy(vertex_nx);
		ds_list_destroy(vertex_ny);
		ds_list_destroy(vertex_nz);
		ds_list_destroy(vertex_xtex);
		ds_list_destroy(vertex_ytex);

		ds_map_destroy(mtl_alpha);
		ds_map_destroy(mtl_color);

		file_text_close(obj_file);
		file_text_close(mtl_file);

		return model;
	}
}