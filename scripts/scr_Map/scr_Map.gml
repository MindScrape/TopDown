// The GameWorld is made up of many maps.
// Each map is a 32x32 section of chunks
function Map(_iPos, _jPos): GameWorld() constructor {
	map = {
		chunks : new Array2(mapLen, mapLen),
		iPos : int64(_iPos),
		jPos : int64(_jPos)
	}
	
	static getChunk = function(xPos, yPos) {
		return chunks.get(xPos / (chunkXlen * abs(map.iPos)), yPos / (chunkYlen * abs(map.jPos)))
	}
	
	static newChunk = function(xPos, yPos) {
		var chunk = new Chunk()
		chunks.set(xPos / (chunkXlen * abs(map.iPos)), yPos / (chunkYlen * abs(map.jPos)), chunk)
		return chunk
	}
	
	static writeBlock = function(xPos, yPos, zPos, blockId) {
		var chunk = getChunk(xPos, yPos)
		if chunk == pointer_null {
			chunk = newChunk(xPos, yPos)
		}
		chunk.set(xPos, yPos, zPos, blockId)
	}
	
	static readBlock = function(xPos, yPos, zPos) {
		var chunk = getChunk(xPos, yPos)
		if chunk == pointer_null {
			show_debug_message("Map is attempting to read from a chunk that does not exist yet. Returning blockIdForUnknownLookups.")
			return blockIdForUnknownLookups
		}
		return chunk.get(xPos, yPos, zPos)
	}
}