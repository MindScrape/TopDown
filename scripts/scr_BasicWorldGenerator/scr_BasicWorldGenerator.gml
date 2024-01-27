// Testing world generation

function BasicWorldGenerator(_mmm, _blockDrawer) constructor {
	
	mmm = _mmm
	blockDrawer = _blockDrawer
	placeBlockAction = new PlaceBlock(_mmm, _blockDrawer)
	
	chunkSize = new Vector3(16, 16, 256)
	heightOffset = 60
	heightIntensity = 5.0
	
	static buildWorld = function() {
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
					placeBlockAction.placeBlock(_x, _y, _z, blockTypeToAssign)
				}
			}
		}
	}
}