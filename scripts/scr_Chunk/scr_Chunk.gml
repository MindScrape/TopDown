// A constructor that holds 3D info on a world chunk
function Chunk() : GameWorld() constructor {
	
	blocks = new Array3(chunkXlen, chunkYlen, chunkZlen)
	
	static set = function(xPos, yPos, zPos, blockId) {
		blocks.set(abs(xPos), abs(yPos), zPos, blockId)
	}
	
	static get = function(xPos, yPos, zPos) {
		return blocks.get(abs(xPos), abs(yPos), zPos)
	}
	
	static toString = function() {
		return blocks.toString()
	}
}