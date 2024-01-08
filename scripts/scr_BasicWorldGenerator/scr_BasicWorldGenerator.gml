// Testing world generation

function BasicWorldGenerator() constructor {
	chunkSize = new Vector3(16, 256, 16)
	//noiseScale = new Vector2(1.0, 1.0)
	//noiseOffset = new Vector2(0.0, 0.0)
	
	heightOffset = 60
	heightIntensity = 5.0
	tempData = new Array3(chunkSize.posX, chunkSize.posY, chunkSize.posZ)
	
	buildWorld = function() {
		shader_set_perlin_noise(150)
		
		for (var _x = 0; _x < chunkSize.posX; _x++) {
			for (var _z = 0; _z < chunkSize.posZ; _z++) {
				
				//var perlinX = noiseOffset.posX + _x / chunkSize.posX * noiseScale.posX
				//var perlinY = noiseOffset.posY + _z / chunkSize.posZ * noiseScale.posY
				// This is a 1:1 mapping for perlin noise rn.
				var heightGen = round(perlin_noise_2d(_x, _z) * heightIntensity + heightOffset)
				
				for (var _y = heightGen; _y >= 0; _y--) {
					var blockTypeToAssign = 0
					// First Layer = grass
					if _y == heightGen {
						blockTypeToAssign = 1
					}
					// Second to Fourth Layer = dirt
					else if _y < heightGen and _y > heightGen - 4 {
						blockTypeToAssign = 2
					}
					// Everything else below except 0 = stone
					else if _y  <= heightGen - 4 and _y > 0 {
						blockTypeToAssign = 3
					}
					// 0th layer = bedrock
					else if _y == 0 {
						blockTypeToAssign = 4
					}
					
					tempData.set(_x, _y, _z, blockTypeToAssign)
				}
			}
		}
		show_debug_message(tempData.toString())
	}
}