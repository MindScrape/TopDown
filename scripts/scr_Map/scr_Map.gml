// The GameWorld is made up of many maps.
// Each map is a 32x32 section of chunks
function Map(_iPos, _jPos): GameWorld() constructor {
	
	map = {
		chunks : new Array2(mapLen, mapLen),
		iPos : int64(_iPos),
		jPos : int64(_jPos)
	}
	
	static __convertXYtoIJ = function(xPos, yPos) {
		xPos = abs(xPos)
		yPos = abs(yPos)
		var iPos = 0
		var jPos = 0
		var iDenominator = chunkXlen * abs(map.iPos)
		var jDenominator = chunkYlen * abs(map.jPos)
		if (iDenominator != 0) iPos = floor(xPos / iDenominator)
		if (jDenominator != 0) jPos = floor(yPos / jDenominator)
		return {
			iPos : iPos,
			jPos : jPos
		}
	}

	static getChunk = function(xPos, yPos) {
		var ijPositions = __convertXYtoIJ(xPos, yPos)
		return map.chunks.get(ijPositions.iPos, ijPositions.jPos)
	}
	
	static newChunk = function(xPos, yPos) {
		var chunk = new Chunk()
		var ijPositions = __convertXYtoIJ(xPos, yPos)
		map.chunks.set(ijPositions.iPos, ijPositions.jPos, chunk)
		return chunk
	}
	
	static writeBlock = function(xPos, yPos, zPos, blockId) {
		var chunk = getChunk(xPos, yPos)
		if chunk == 0 {
			chunk = newChunk(xPos, yPos)
		}
		chunk.set(xPos, yPos, zPos, blockId)
	}
	
	static readBlock = function(xPos, yPos, zPos) {
		var chunk = getChunk(xPos, yPos)
		if chunk == 0 {
			show_debug_message("Map is attempting to read from a chunk that does not exist yet. Returning default value for unknown lookups.")
			return defaultValueForUnknownLookups
		}
		return chunk.get(xPos, yPos, zPos)
	}
	
	static toString = function() {
		return "This map is for iPos " + string(map.iPos) + " and jPos " + string(map.jPos)
	}
}