// Testing world generation

function BasicWorldGenerator() constructor {
	chunkSize = new Vector3(16, 16, 256)
	//noiseScale = new Vector2(1.0, 1.0)
	//noiseOffset = new Vector2(0.0, 0.0)
	
	heightOffset = 60
	heightIntensity = 5.0
	tempData = new ChunkArray(chunkSize.posX, chunkSize.posY, chunkSize.posZ)
	
	buildWorld = function(render = false) {
		shader_set_perlin_noise(150)
		for (var _x = 0; _x < chunkSize.posX; _x++) {
			for (var _y = 0; _y < chunkSize.posY; _y++) {
				
				//var perlinX = noiseOffset.posX + _x / chunkSize.posX * noiseScale.posX
				//var perlinY = noiseOffset.posY + _z / chunkSize.posZ * noiseScale.posY
				// This is a 1:1 mapping for perlin noise rn.
				var heightGen = round(perlin_noise_2d(_x, _y) * heightIntensity + heightOffset)
				
				for (var _z = heightGen; _z >= 0; _z--) {
					var blockTypeToAssign = 0
					// First Layer = grass
					if _z == heightGen {
						blockTypeToAssign = 1
					}
					// Second to Fourth Layer = dirt
					else if _z < heightGen and _z > heightGen - 4 {
						blockTypeToAssign = 2
					}
					// Everything else below except 0 = stone
					else if _z  <= heightGen - 4 and _z > 0 {
						blockTypeToAssign = 3
					}
					// 0th layer = bedrock
					else if _z == 0 {
						blockTypeToAssign = 4
					}
					tempData.set(_x, _y, _z, blockTypeToAssign)
				}
			}
		}
		//show_debug_message(tempData.toString())
		if (render) {
			for (var _x = 0; _x < chunkSize.posX; _x++) {
				for (var _y = 0; _y < chunkSize.posY; _y++) {
					for (var _z = 0; _z < chunkSize.posZ; _z++) {
						
						var block = tempData.get(_x, _y, _z)
						if block == 0 {
							continue
						}
						
						// Naive approach to rendering the block
						
						var front = tempData.get(_x, _y + 1, _z)
						var back = tempData.get(_x, _y + 1, _z)
						var left = tempData.get(_x - 1, _y, _z)
						var right = tempData.get(_x, _y + 1, _z)
						var top = tempData.get(_x, _y, _z + 1)
						var bottom = tempData.get(_x, _y, _z - 1)
						
						if (front == 0 or back == 0 or left == 0 or right == 0 or top == 0 or bottom == 0) {
							new Block(_x, _y, _z, block).render()
						}
					}
				}
			}
		}
	}
}