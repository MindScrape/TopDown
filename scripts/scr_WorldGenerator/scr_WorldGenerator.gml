// Generates the world around a fixed point (as of now)
// @inherits The GameWorld static data.
// @param A world generator needs an object of type PlaceBlock (See: scr_PlaceBlock)
function WorldGenerator(_placeBlockAction, _randSeed = 150, _renderDistance = 5) : GameWorld() constructor {
	
	static placeBlockAction = _placeBlockAction
	static randSeed = _randSeed
	static renderDistance = _renderDistance
	
	// From the player to its horizon
	static lineOfSight = _renderDistance * chunkXlen
	
	static initWorldGenerator = function() {
		shader_set_perlin_noise(_randSeed)
		return self
	}
	
	static generateChunk = function() {
		
	}
}